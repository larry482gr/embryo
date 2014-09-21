<?php 
	class ModelSurvey extends Model {
		public function findAll($lang_id) {
			$query = "SELECT * FROM surveys WHERE lang_id = ".$lang_id;
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
	}
?>