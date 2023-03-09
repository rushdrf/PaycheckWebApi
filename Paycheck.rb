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
            when 0..20000 then 0 * getTaxPercentage()
            when 20001..40000 then (@yearlySalary - 20000) * getTaxPercentage()
            when 40001..80000 then (@yearlySalary - 40000) * getTaxPercentage()
            when 80001..180000 then (@yearlySalary - 80000) * getTaxPercentage()
            else (@yearlySalary - 180000) * getTaxPercentage()
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

class MainClass
    def generate_monthly_payslip

        puts "Please enter your name: "
        name = gets.chomp

        puts "Please enter your annual salary: "
        annualSal = gets.chomp.to_i

        if annualSal == 0
            puts "Invalid Input"
        else
            model = PaycheckModel.new(name, annualSal)

            puts "Monthly Payslip for: #{model.getName}"
            puts "Gross Monthly Income: #{to_2decimal(model.getMonthlySalary)}"
            puts "Monthly Income Tax: #{to_2decimal(model.getMonthlyTaxAmount)}"
            puts "Net Monthly Income: #{to_2decimal(model.getMontlyNetSalary)}"
        end
    end

    def to_2decimal(value)
        return sprintf("%.2f", value)
    end

    private :to_2decimal
end

run = MainClass.new
run.generate_monthly_payslip