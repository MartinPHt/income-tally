namespace Common.Entities
{
    public class Expense : BaseEntity
    {
        public Expense(string title, double total, ExpenseCategory category, bool isRecurring, DateTime date)
        {
            Title = title;
            Total = total;
            Category = category;
            IsRecurring = isRecurring;
            Date = date;
        }

        public Expense()
        {

        }

        public string Title { get; set; }
        public double Total { get; set; }
        public ExpenseCategory Category { get; set; }
        public bool IsRecurring { get; set; }
        public DateTime Date { get; set; }
    }
    public enum ExpenseCategory
    {
        Housing,
        Food,
        Transportation,
        Health,
        Education,
        Entertainment,
        Clothing,
        Other
    }
}
