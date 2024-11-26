using IncomeTallyAPI.Repositories;
using Common.CommConstants;
using Common.Entities;
using Microsoft.AspNetCore.Mvc;

namespace IncomeTallyAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ManageExpensesController : ControllerBase
    {
        private readonly ExpenseRepository _expensesRepo;

        public ManageExpensesController()
        {
            _expensesRepo = new ExpenseRepository();
        }

        [HttpPost]
        public async Task<IActionResult> CreateExpense([FromBody] CreateExpenseRequest request)
        {
            try
            {
                var expense = new Expense(request.Title, request.Total, request.Category, request.IsRecurring, request.Date);
                _expensesRepo.Save(expense);

                var response = GenerateResponse(expense);
                return CreatedAtAction(nameof(GetExpense), new { id = expense.Id }, response);
            }
            catch (Exception ex)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, new { error = "An error occurred while processing your request.", details = ex.Message });
            }
        }

        // Retrieve by ID
        [HttpGet("{id}")]
        public IActionResult GetExpense(int id)
        {
            try
            {
                var expense = _expensesRepo.GetAll(n => n.Id == id).Find(i => i.Id == id);
                if (expense == null)
                {
                    return NotFound();
                }

                var response = GenerateResponse(expense);
                return Ok(response);
            }
            catch (Exception ex)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, new { error = "An error occurred while processing your request.", details = ex.Message });
            }
        }

        // Retrieve all
        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            try
            {
                var allExpenses = _expensesRepo.GetAll(i => true);
                var response = allExpenses.Select(expense => GenerateResponse(expense)).ToList();

                //Simulate delay
                await Task.Delay(1000);
                return Ok(response);
            }
            catch (Exception ex)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, new { error = "An error occurred while processing your request.", details = ex.Message });
            }
        }

        // Update
        [HttpPut("{id}")]
        public IActionResult UpdateExpense(int id, [FromBody] UpdateExpenseRequest request)
        {
            try
            {
                var expense = _expensesRepo.GetAll(n => n.Id == id).Find(i => i.Id == id);
                if (expense == null)
                {
                    return NotFound();
                }

                expense.Title = request.Title;
                expense.Total = request.Total;
                expense.Category = request.Category;
                expense.IsRecurring = request.IsRecurring;
                expense.Date = request.Date;

                _expensesRepo.Save(expense);
                return new JsonResult(Ok());
            }
            catch (Exception ex)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, new { error = "An error occurred while processing your request.", details = ex.Message });
            }
        }

        // Delete
        [HttpDelete("{id}")]
        public IActionResult DeleteExpense(int id)
        {
            try
            {
                var expense = _expensesRepo.GetAll(n => n.Id == id).Find(i => i.Id == id);
                if (expense == null)
                {
                    return NotFound();
                }

                _expensesRepo.Delete(expense);
                return Ok();
            }
            catch (Exception ex)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, new { error = "An error occurred while processing your request.", details = ex.Message });
            }
        }

        [HttpGet("search/{filter}/{searchWord}")]
        public IActionResult SearchExpensesByDetails(string filter, string searchWord)
        {
            try
            {
                List<Expense> expensesSearchResult;
                expensesSearchResult = _expensesRepo.GetAll(n => n.Title.ToUpper().Replace(" ", "").Contains(searchWord.ToUpper()));

                var response = expensesSearchResult.Select(expense => GenerateResponse(expense)).ToList();
                return Ok(response);
            }
            catch (Exception ex)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, new { error = "An error occurred while processing your request.", details = ex.Message });
            }
        }

        private ExpenseResponse GenerateResponse(Expense expense)
        {
            return new ExpenseResponse
            {
                Id = expense.Id,
                Title = expense.Title,
                Total = expense.Total,
                Category = expense.Category,
                IsRecurring = expense.IsRecurring,
                Date = expense.Date,
            };
        }
    }
}
