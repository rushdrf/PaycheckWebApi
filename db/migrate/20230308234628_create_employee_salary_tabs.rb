class CreateEmployeeSalaryTabs < ActiveRecord::Migration[7.0]
  def change
    create_table :employee_salary_tabs do |t|
      t.datetime :Timestamp
      t.string :EmployeeName
      t.decimal :AnnualSalary, precision: 12, scale: 2
      t.decimal :MonthlyIncomeTax, precision: 8, scale: 2

      t.timestamps
    end
  end
end
