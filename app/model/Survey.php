<?php 
	class ModelSurvey extends Model {
		public function findAll($lang_id) {
			$query = "SELECT * FROM surveys WHERE lang_id = ".$lang_id;
			$result = $this->db_survey->query($query);
			return $result->rows;
		}
		
		public function findSurvey($id) {
			$query = "SELECT id, title, is_public FROM surveys WHERE id = ".$id;
			$result = $this->db_survey->query($query);
			return $result->row;
		}
		
		public function findPageSurvey($alias) {
			$query = "SELECT id FROM surveys WHERE alias = '".$alias."' AND is_public = 1 AND is_active = 1 AND has_errors = 0";
			$result = $this->db_survey->query($query);
			return $result->row;
		}
		
		public function findPublicSurvey($id) {
			$query = "SELECT id, title FROM surveys WHERE id = ".$id." AND is_public = 1 AND is_active = 1 AND has_errors = 0";
			$result = $this->db_survey->query($query);
			return isset($result->row) ? $result->row : false;
		}
		
		public function findSurveyCategories($survey_id) {
			$query = "SELECT * FROM categories WHERE survey_id = ".$survey_id;
			$result = $this->db_survey->query($query);
			return $result->rows;
		}
		
		public function findSurveySubcategories($category_id) {
			$query = "SELECT * FROM subcategories WHERE cat_id = ".$category_id;
			$result = $this->db_survey->query($query);
			return $result->rows;
		}
		
		public function findSurveyQuestions($subcategory_id) {
			$query = "SELECT * FROM questions WHERE subcat_id = ".$subcategory_id;
			$result = $this->db_survey->query($query);
			return $result->rows;
		}
		
		public function findQuestionTypes() {
			$query = "SELECT * FROM question_types";
			$result = $this->db_survey->query($query);
			return $result->rows;
		}
		
		public function createSurvey($lang_id, $surveyTitle, $surveyAlias, $surveyIsPublic) {
			$surveyAlias = empty($surveyAlias) ? 'NULL' : "'".$surveyAlias."'";
			$query = "INSERT INTO surveys (title, lang_id, alias, is_public)
					  VALUES ('".$surveyTitle."', ".$lang_id.", ".$surveyAlias.", ".$surveyIsPublic.")";
			$this->db_survey->query($query);
			return $this->db_survey->getLastId();
		}
		
		public function createSurveyCategory($surveyId, $categoryLabel) {
			$query = "INSERT INTO categories (survey_id, label)
					  VALUES (".$surveyId.", '".$categoryLabel."')";
			$this->db_survey->query($query);
			return $this->db_survey->getLastId();
		}
		
		public function createSurveySubcategory($surveyCatId, $subcategoryHeader, $subcategoryLabel) {
			$subcategoryHeader = empty($subcategoryHeader) ? 'NULL' : "'".$subcategoryHeader."'";
			$query = "INSERT INTO subcategories (cat_id, header, label)
					  VALUES (".$surveyCatId.", ".$subcategoryHeader.", '".$subcategoryLabel."')";
			$this->db_survey->query($query);
			return $this->db_survey->getLastId();
		}
		
		public function createSurveyQuestion($surveySubcatId, $question) {
			$query = "INSERT INTO questions (subcat_id, type, text, help, answer_options, has_other, has_comment)
					  VALUES (".$surveySubcatId.", ".$question['type'].", ".$question['text'].", ".$question['help'].", ".$question['answer_options'].", ".$question['has_other'].", ".$question['has_comment'].")";
			$this->db_survey->query($query);
		}
	}
?>