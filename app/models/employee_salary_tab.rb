class EmployeeSalaryTab < ApplicationRecord
    attribute :Timestamp, :datetime
    attribute :EmployeeName, :string
    attribute :AnnualSalary, :decimal, precision: 12, scale: 2
    attribute :MonthlyIncomeTax, :decimal, precision: 8, scale: 2
end
