class SurveyAerialSampleCount < ActiveRecord::Base
  include Count

  belongs_to :population_submission

  has_many :survey_aerial_sample_count_strata

  validates_with StratumLevelValidator
end
