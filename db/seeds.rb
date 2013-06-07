# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)





Field.delete_all
FieldStatus.delete_all
RecordReview.delete_all
PracticeRecord.delete_all
FacilityReturn.delete_all
FacilityApplication.delete_all
CourseReview.delete_all
ScheduledCourse.delete_all
ScheduledFacility.delete_all
Course.delete_all
FacilityTotal.delete_all
FacilityIo.delete_all
FacilityReason.delete_all
Facility.delete_all
TempUser.delete_all
StockingDetail.delete_all
Stocking.delete_all
UserRoleMapping.delete_all
Role.delete_all
User.delete_all



TempUser.create(
    :teacher_id => 100001,
    :teacher_name => '陈易',
    :department => '烹饪'
)

TempUser.create(
    :teacher_id => 100002,
    :teacher_name => '张仁勇',
    :department => '机械'
)

TempUser.create(
    :teacher_id => 100003,
    :teacher_name => '一帆',
    :department => '矿石开采'
)

FacilityReason.create(
    :reason => '新购买',
    :if_add => true,
    :systematic => true
)
FacilityReason.create(
    :reason => '消耗',
    :if_add => false,
    :systematic => true
)
FacilityReason.create(
    :reason => '丢失',
    :if_add => false,
    :systematic => true
)
FacilityReason.create(
    :reason => '损坏',
    :if_add => false,
    :systematic => true
)
FacilityReason.create(
    :reason => '维修返回',
    :if_add => true,
    :systematic => true
)
FacilityReason.create(
    :reason => '维修',
    :if_add => false,
    :systematic => true
)
FacilityReason.create(
    :reason => '找回',
    :if_add => true,
    :systematic => true
)
FacilityReason.create(
    :reason => '课程消耗',
    :if_add => false,
    :systematic => true
)
FacilityReason.create(
    :reason => '课程损耗',
    :if_add => false,
    :systematic => true
)
FacilityReason.create(
    :reason => '资产盘点缺失',
    :if_add => false,
    :systematic => true
)

FacilityReason.create(
    :reason => '资产盘点盈余',
    :if_add => true,
    :systematic => true
)

FieldStatus.create(
    :name => '正常使用',
    :available => true,
    :systematic => true
)

FieldStatus.create(
    :name => '维修中',
    :available => false,
    :systematic => true
)

FieldStatus.create(
    :name => '临时关闭',
    :available => false,
    :systematic => true
)

FieldStatus.create(
    :name => '其他占用',
    :available => false,
    :systematic => true
)

Role.create(
    :name => 'sysadmin',
    :friendly_name => '系统管理员'
)

Role.create(
    :name => 'storeadmin',
    :friendly_name => '实训管理员'
)

Role.create(
    :name => 'schooladmin',
    :friendly_name => '学校领导'
)

Role.create(
    :name => 'teacher',
    :friendly_name => '教职人员'
)

User.create(
    :account => 'sysadmin',
    :name => '系统管理员',
    :password => 'password'
)


User.create(
    :account => 'master',
    :name => '校长',
    :password => 'password'
)

User.create(
    :account => 'admin',
    :name => '实训管理员',
    :password => 'password'
)

User.create(
    :account => 't1',
    :name => '教师1',
    :password => 'password'
)

User.create(
    :account => 't2',
    :name => '教师2',
    :password => 'password'
)

UserRoleMapping.create(
    :user_id => User.find_by_account('sysadmin').id,
    :role_id => Role.find_by_name('sysadmin').id
)

UserRoleMapping.create(
    :user_id => User.find_by_account('master').id,
    :role_id => Role.find_by_name('schooladmin').id
)

UserRoleMapping.create(
    :user_id => User.find_by_account('admin').id,
    :role_id => Role.find_by_name('storeadmin').id
)

UserRoleMapping.create(
    :user_id => User.find_by_account('t1').id,
    :role_id => Role.find_by_name('teacher').id
)

UserRoleMapping.create(
    :user_id => User.find_by_account('t2').id,
    :role_id => Role.find_by_name('teacher').id
)