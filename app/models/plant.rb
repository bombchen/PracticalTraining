# encoding: utf-8
class Plant < ActiveRecord::Base
  attr_accessible :description, :name, :status_id
end
