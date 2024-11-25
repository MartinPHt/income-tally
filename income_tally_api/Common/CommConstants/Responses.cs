using Common.Entities;

namespace Common.CommConstants
{
    #region Base Response
    public interface IResponse
    {
        bool Successfull { get; }
    }

    public abstract class Response : IResponse
    {
        public Response(bool isSuccessfull)
        {
            Successfull = isSuccessfull;
        }
        public bool Successfull { get; }
    }
    #endregion

    #region Expense Request
    public class ExpenseResponse
    {
        public int Id { get; set; }
        public string? Title { get; set; }
        public double Total { get; set; }
        public string Category { get; set; }
        public bool IsRecurring { get; set; }
        public DateTime Date { get; set; }
    }
    #endregion
}
