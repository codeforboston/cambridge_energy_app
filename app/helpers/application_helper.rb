module ApplicationHelper

    def get_bill(user,date)
        bill_at_date = user.bills.select { |bill| bill.bill_received.year == date.year && bill.bill_received.month == date.month }
        if bill_at_date.length == 0
            message = "No bills this month"
        elsif bill_at_date.length > 1
            message = "Too many bills submitted"
        else
            message = bill_at_date.first.usage
        end
    end

end
