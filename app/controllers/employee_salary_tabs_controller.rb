class EmployeeSalaryTabsController < ApplicationController
    def salary_compute
        salary_computations = EmployeeSalaryTab.all.map do |tab|
        {
            time_stamp: tab.Timestamp.strftime("%Y-%m-%d %H:%M:%S"),
            employee_name: tab.EmployeeName,
            annual_salary: tab.AnnualSalary.to_s,
            monthly_income_tax: tab.MonthlyIncomeTax.to_s
        }
        end
    
        render json: { salary_computations: salary_computations }
    end
end