class ApiController < ApplicationController
    def create
        employee_name = params[:employee_name]
        annual_salary = params[:annual_salary].to_i

        if annual_salary == 0
            render json: { ErrorMessage: 'Invalid Input' }, status: :created
        else
            model = PaycheckModel.new(employee_name, annual_salary)

            render json: {
                "employee_name": model.getName,
                "gross_monthly_income": to_2decimal(model.getMonthlySalary),
                "monthly_income_tax": to_2decimal(model.getMonthlyTaxAmount),
                "net_monthly_income": to_2decimal(model.getMontlyNetSalary),
                }, status: :created
        end

    end

    def to_2decimal(value)
        return sprintf("%.2f", value)
    end

    private :to_2decimal
end

class PaycheckModel
    @@monthInYear = 12

    def initialize(name, yearlySalary)
        @name, @yearlySalary = name, yearlySalary
    end

    def getName
        return @name
    end

    def getTaxPercentage
        result = case @yearlySalary
            when 0..20000 then 0
            when 20001..40000 then 0.1
            when 40001..80000 then 0.2
            when 80001..180000 then 0.3
            else 0.4
        end
        return result
    end

    def getTaxableAmount
        result = case @yearlySalary
            when 0..20000 then 0
            when 20001..40000 then @yearlySalary - 20000
            when 40001..80000 then @yearlySalary - 40000
            when 80001..180000 then @yearlySalary - 80000
            else @yearlySalary - 180000
        end
        return result
    end

    def calTotalTax
        return getTaxableAmount() * getTaxPercentage()
    end

    def getMonthlySalary
        return (@yearlySalary/@@monthInYear).to_f
    end

    def getMonthlyTaxAmount
        return (calTotalTax()/@@monthInYear).to_f
    end
    
    def getMontlyNetSalary
        return (getMonthlySalary() - getMonthlyTaxAmount()).to_f
    end
end