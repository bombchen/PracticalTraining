# encoding: utf-8
class ReportsController < ApplicationController

  append_before_filter :ensure_school_or_store_admin

  def instore
    dt = params[:dt]
    @begin_date = (dt.nil? ? 1.month.ago.to_date : dt)
    @end_date = Date.today
    @facilities = Facility.find_by_sql ['SELECT f.* FROM facilities f ' +
                                            'INNER JOIN facility_ios fio on f.id = fio.facility_id ' +
                                            'WHERE fio.date BETWEEN ? AND ?',
                                        @begin_date, @end_date]
    @records = FacilityIo.find_by_sql ['SELECT fio.* FROM facility_ios fio ' +
                                           'INNER JOIN facility_reasons fr ON fio.reason_id = fr.id ' +
                                           'WHERE fio.date BETWEEN ? AND ? ' +
                                           'AND fr.if_add = 1',
                                       @begin_date, @end_date]

    @reports = Hash.new
    @facilities.each do |f|
      @reports[f] = ReportUnitIO.new(f)
      @reports[f].remaining = f.facility_total.total
    end
    @records.each do |r|
      @reports[r.facility].in_amount += r.amount
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def consume
    dt = params[:dt]
    @begin_date = (dt.nil? ? 1.month.ago.to_date : dt)
    @end_date = Date.today
    @facilities = Facility.find_by_sql ['SELECT f.* FROM facilities f ' +
                                            'INNER JOIN facility_ios fio on f.id = fio.facility_id ' +
                                            'WHERE fio.date BETWEEN ? AND ?',
                                        @begin_date, @end_date]
    @records = FacilityIo.find_by_sql ['SELECT fio.* FROM facility_ios fio ' +
                                           'INNER JOIN facility_reasons fr ON fio.reason_id = fr.id ' +
                                           'WHERE fio.date BETWEEN ? AND ? ' +
                                           'AND fr.if_add = 0 '+
                                           'AND (fr.reason = "课程消耗" OR fr.reason = "消耗")',
                                       @begin_date, @end_date]

    @reports = Hash.new
    @facilities.each do |f|
      @reports[f] = ReportUnitIO.new(f)
      @reports[f].remaining = f.facility_total.total
    end
    @records.each do |r|
      @reports[r.facility].out_amount += r.amount
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def lost
    dt = params[:dt]
    @begin_date = (dt.nil? ? 1.month.ago.to_date : dt)
    @end_date = Date.today
    @facilities = Facility.find_by_sql ['SELECT f.* FROM facilities f ' +
                                            'INNER JOIN facility_ios fio on f.id = fio.facility_id ' +
                                            'WHERE fio.date BETWEEN ? AND ?',
                                        @begin_date, @end_date]
    @records = FacilityIo.find_by_sql ['SELECT fio.* FROM facility_ios fio ' +
                                           'INNER JOIN facility_reasons fr ON fio.reason_id = fr.id ' +
                                           'WHERE fio.date BETWEEN ? AND ? ' +
                                           'AND fr.if_add = 0 '+
                                           'AND fr.reason <> "课程消耗" AND fr.reason <> "消耗"',
                                       @begin_date, @end_date]

    @reports = Hash.new
    @facilities.each do |f|
      @reports[f] = ReportUnitIO.new(f)
      @reports[f].remaining = f.facility_total.total
    end
    @records.each do |r|
      @reports[r.facility].out_amount += r.amount
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def category
    dt = params[:dt]
    typ = params[:typ]
    @begin_date = (dt.nil? ? 1.month.ago.to_date : dt)
    @end_date = Date.today
    @filter_category = (typ.nil? ? -1 : typ.to_i)

    if (@filter_category == -1)
      @facilities = Facility.find_by_sql ['SELECT f.* FROM facilities f ' +
                                              'INNER JOIN facility_ios fio on f.id = fio.facility_id ' +
                                              'WHERE fio.date BETWEEN ? AND ?',
                                          @begin_date, @end_date]
    else
      @facilities = Facility.find_by_sql ['SELECT f.* FROM facilities f ' +
                                              'INNER JOIN facility_ios fio on f.id = fio.facility_id ' +
                                              'WHERE f.category_id = ? ' +
                                              'AND fio.date BETWEEN ? AND ?',
                                          @filter_category, @begin_date, @end_date]
    end

    @records = FacilityIo.find_by_sql ['SELECT fio.* FROM facility_ios fio ' +
                                           'WHERE fio.date BETWEEN ? AND ? ',
                                       @begin_date, @end_date]

    @reports = Hash.new
    @facilities.each do |f|
      @reports[f] = ReportUnitIO.new(f)
      @reports[f].remaining = f.facility_total.total
    end
    @records.each do |r|
      next if (!@facilities.include? r.facility)
      if r.facility_reason.if_add
        @reports[r.facility].in_amount += r.amount
      else
        @reports[r.facility].out_amount += r.amount
      end
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def department
    dt = params[:dt]
    dep = params[:dep]
    @begin_date = (dt.nil? ? 1.month.ago.to_date : dt)
    @end_date = Date.today
    @filter_department = (dep.nil? ? -1 : dep.to_i)


    if (@filter_department == -1)
      @facilities = Facility.find_by_sql ['SELECT f.* FROM facilities f ' +
                                              'INNER JOIN facility_ios fio on f.id = fio.facility_id ' +
                                              'WHERE fio.date BETWEEN ? AND ?',
                                          @begin_date, @end_date]
    else
      @facilities = Facility.find_by_sql ['SELECT f.* FROM facilities f ' +
                                              'INNER JOIN facility_ios fio on f.id = fio.facility_id ' +
                                              'WHERE f.department_id = ? ' +
                                              'AND fio.date BETWEEN ? AND ?',
                                          @filter_department, @begin_date, @end_date]
    end

    @records = FacilityIo.find_by_sql ['SELECT fio.* FROM facility_ios fio ' +
                                           'WHERE fio.date BETWEEN ? AND ? ',
                                       @begin_date, @end_date]

    @reports = Hash.new
    @facilities.each do |f|
      @reports[f] = ReportUnitIO.new(f)
      @reports[f].remaining = f.facility_total.total
    end
    @records.each do |r|
      next if (!@facilities.include? r.facility)
      if r.facility_reason.if_add
        @reports[r.facility].in_amount += r.amount
      else
        @reports[r.facility].out_amount += r.amount
      end
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def teacher
    dt = params[:dt]
    tch = params[:tch]
    @begin_date = (dt.nil? ? 1.month.ago.to_date : dt)
    @end_date = Date.today
    @filter_teacher = (tch.nil? ? -1 : tch.to_i)

    @facilities = Facility.find_by_sql ['SELECT f.* FROM facilities f ' +
                                            'INNER JOIN facility_ios fio on f.id = fio.facility_id ' +
                                            'WHERE fio.date BETWEEN ? AND ?',
                                        @begin_date, @end_date]

    if (@filter_teacher == -1)
      trid = Role.find_by_name('teacher').id
      tlst = User.find_by_sql ['SELECT u.id FROM users u ' +
                                   'INNER JOIN user_role_mappings m ON u.id = m.user_id ' +
                                   'WHERE m.role_id = ?',
                               trid]
      strlst = Array.new
      tlst.each do |t|
        strlst.push(t.id)
      end
      tstr = strlst.join(',')
      query = 'SELECT fio.* FROM facility_ios fio ' +
          'WHERE fio.date BETWEEN "'+ @begin_date.to_s+'" AND "'+@end_date.to_s+'" ' +
          'AND fio.owner_id IN ('+tstr+')'
      @records = FacilityIo.find_by_sql query
    else
      @records = FacilityIo.find_by_sql ['SELECT fio.* FROM facility_ios fio ' +
                                             'WHERE fio.owner_id = ? ' +
                                             'AND fio.date BETWEEN ? AND ?',
                                         @filter_teacher, @begin_date, @end_date]
    end

    @user_reports = Hash.new
    @records.each do |r|
      next if (r.user.nil?)
      if (@user_reports[r.user].nil?)
        @user_reports[r.user] = UserReportUnit.new(r.user)
      end
      if (@user_reports[r.user].portfolio[r.facility].nil?)
        @user_reports[r.user].portfolio[r.facility] = ReportUnitIO.new(r.facility)
        @user_reports[r.user].portfolio[r.facility].remaining = r.facility.facility_total.total
      end
      if (r.facility_reason.if_add)
        @user_reports[r.user].portfolio[r.facility].in_amount += r.amount
      else
        @user_reports[r.user].portfolio[r.facility].out_amount += r.amount
      end
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def overall
    dt = params[:dt]
    @begin_date = (dt.nil? ? 1.month.ago.to_date : dt)
    @end_date = Date.today
    @facilities = Facility.find_by_sql ['SELECT f.* FROM facilities f ' +
                                            'INNER JOIN facility_ios fio on f.id = fio.facility_id ' +
                                            'WHERE fio.date BETWEEN ? AND ?',
                                        @begin_date, @end_date]
    @records = FacilityIo.find_by_sql ['SELECT fio.* FROM facility_ios fio ' +
                                           'INNER JOIN facility_reasons fr ON fio.reason_id = fr.id ' +
                                           'WHERE fio.date BETWEEN ? AND ?',
                                       @begin_date, @end_date]

    @reports = Hash.new
    @facilities.each do |f|
      @reports[f] = ReportUnitIO.new(f)
      @reports[f].remaining = f.facility_total.total
    end
    @records.each do |r|
      next if (!@facilities.include? r.facility)
      if r.facility_reason.if_add
        @reports[r.facility].in_amount += r.amount
      else
        @reports[r.facility].out_amount += r.amount
      end
    end

    respond_to do |format|
      format.html
      format.js
    end
  end
end
