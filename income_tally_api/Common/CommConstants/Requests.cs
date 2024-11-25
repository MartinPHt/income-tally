using Common.Entities;

namespace Common.CommConstants
{
    #region Base Requests
    public abstract class DataRequest : IRequest
    {
        public bool ContainsData
        {
            get { return true; }
        }
    }

    public abstract class NoDataRequest : IRequest
    {
        public bool ContainsData
        {
            get { return false; }
        }
    }
    #endregion

    #region Expense Requests
    public class CreateExpenseRequest : DataRequest
    {
        public CreateExpenseRequest(string title, double total, string category, bool isRecurring, DateTime date)
            : base()
        {
            Title = title;
            Total = total;
            Category = category;
            IsRecurring = isRecurring;
            Date = date;
        }
        public string Title { get; set; }
        public double Total { get; set; }
        public string Category { get; set; }
        public bool IsRecurring { get; set; }
        public DateTime Date { get; set; }
    }

    public class UpdateExpenseRequest : DataRequest
    {
        public UpdateExpenseRequest(int id, string title, double total, string category, bool isRecurring, DateTime date)
            : base()
        {
            Id = id;
            Title = title;
            Total = total;
            Category = category;
            IsRecurring = isRecurring;
            Date = date;
        }

        public int Id { get; set; }
        public string Title { get; set; }
        public double Total { get; set; }
        public String Category { get; set; }
        public bool IsRecurring { get; set; }
        public DateTime Date { get; set; }
    }
    #endregion
}
