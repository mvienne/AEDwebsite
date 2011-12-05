class SurveyAerialTotalCount < ActiveRecord::Base
  include Count

  validates_presence_of :surveyed_at_stratum_level
  validates_presence_of :stratum_level_data_submitted

  belongs_to :population_submission

  has_many :survey_aerial_total_count_strata

end
