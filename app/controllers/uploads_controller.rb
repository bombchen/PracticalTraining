# encoding:utf-8

require 'spreadsheet'

class UploadsController < ApplicationController

  def create
    begin
      name = Time.now.to_s + rand(99999).to_s + params[:Filename].split("\.")[1]
      directory = 'public'

      path = File.join(directory, name)
      File.open(path, "wb") { |f| f.write(params[:file].read) }

      sheet = Spreadsheet.open(path,'r').worksheet(0)

      sheet.each_with_index do |row,index|
        next if index == 0
        break if row[0].nil?

        facility = Facility.new

        facility.name = row[0].is_a?(Spreadsheet::Formula) ? row[0].value : row[0]
        facility.unit = row[1].is_a?(Spreadsheet::Formula) ? row[1].value : row[1]
        facility.alert_amount = row[2].is_a?(Spreadsheet::Formula) ? row[2].value : row[2]

        facility_type_name = row[3].is_a?(Spreadsheet::Formula) ? row[3].value : row[3]
        facility.facility_type = Facility.facility_type_id(facility_type_name)


        category_name = row[4].is_a?(Spreadsheet::Formula) ? row[4].value : row[4]
        category = FacilityCategory.where(:name => category_name)[0]
        facility.category_id = category.id

        department_name = row[5].is_a?(Spreadsheet::Formula) ? row[5].value : row[5]
        department = Department.where(:name =>department_name)[0]
        facility.department_id = department.id

        asset_id = row[6].is_a?(Spreadsheet::Formula) ? row[6].value : row[6]
        asset_id = asset_id.to_i unless asset_id.nil?
        facility.asset_id = asset_id.to_i

        unit_price = row[7].is_a?(Spreadsheet::Formula) ? row[7].value : row[7]
        facility.unit_price = unit_price.to_f

        8.upto(50) do |index|
          break if row[index].nil?
          facilityProperty = FacilityProperty.new
          column_value = row[index].is_a?(Spreadsheet::Formula) ? row[index].value : row[index]
          name, value = column_value.split("=") unless column_value.nil?
          facilityProperty.property_name = name
          facilityProperty.property_value = value
          facility.facility_properties << facilityProperty
        end

        facility.save
      end

      File.delete(path)

      render :text => 'ok'
    rescue
      raise
    ensure

    end
  end
end
