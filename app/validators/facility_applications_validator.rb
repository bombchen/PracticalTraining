class FacilityApplicationsValidator < ActiveModel::Validator
  def validate(record)
    if has_duplicate_applications record.facility_applications
      #record.errors.add :base, "申请材料重复"
    end
  end

  private
  def has_duplicate_applications(apps)
    if apps != nil
      return true
    end
  end
end