class Submission < ActiveRecord::Base
  has_paper_trail

  # All normal attributes of this model are mass-assignable
  # except user_id which will be set in the controller
  attr_protected :created_at, :updated_at, :user_id

  validates_presence_of :species
  validates_presence_of :country
  validates_presence_of :data_type

  belongs_to :user
  belongs_to :country
  belongs_to :species

  has_many :population_submissions

  has_many :survey_aerial_sample_counts, :through => :population_submissions
  has_many :survey_aerial_total_counts, :through => :population_submissions
  has_many :survey_dung_count_line_transects, :through => :population_submissions
  has_many :survey_faecal_dnas, :through => :population_submissions
  has_many :survey_ground_sample_counts, :through => :population_submissions
  has_many :survey_ground_total_counts, :through => :population_submissions
  has_many :survey_individual_registrations, :through => :population_submissions
  has_many :survey_others, :through => :population_submissions

  belongs_to :species
  belongs_to :country

  def range_states
    if species.nil?
      {}
    else
      species.range_states
    end
  end

  class SubmissionValidator < ActiveModel::Validator
    def validate(record)
      if record.phenotype == "" and record.species.scientific_name == "Loxodonta africana"
        record.errors[:phenotype] << "must be answered if you are reporting on Loxodonta africana"
      end
      if record.phenotype_basis == "" and record.phenotype != "Unknown" and record.species.scientific_name == "Loxodonta africana"
        record.errors[:phenotype_basis] << "must be answered if you are reporting on Loxodonta africana"
      end
      if record.right_to_grant_permission.nil?
        record.errors[:right_to_grant_permission] << "can't be blank"
      end
    end
  end

  validates_with SubmissionValidator
end
