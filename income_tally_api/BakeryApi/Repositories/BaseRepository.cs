using Microsoft.EntityFrameworkCore;
using Common.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;
using IncomeTallyAPI.Database;

namespace IncomeTallyAPI.Repositories
{
    public class BaseRepository<T>
        where T : BaseEntity
    {
        protected DbContext Context { get; set; }
        protected DbSet<T> Items { get; set; }

        public BaseRepository()
        {
            Context = new DBIncomeTallyContext();
            Items = Context.Set<T>();
        }

        public List<T> GetAll(Expression<Func<T, bool>> filter = null,
                              Expression<Func<T, object>> orderBy = null,
                              int page = 1,
                              int itemsPerPage = Int32.MaxValue)
        {
            IQueryable<T> query = Items;

            if (filter != null)
                query = query.Where(filter);

            if (orderBy != null)
                query = query.OrderBy(orderBy);

            return query
                    .Skip(itemsPerPage * (page - 1))
                    .Take(itemsPerPage)
                    .ToList();
        }

        public T GetFirstOrDefault(Expression<Func<T, bool>> filter = null)
        {
            IQueryable<T> query = Items;

            if (filter != null)
                query = query.Where(filter);

            return query.FirstOrDefault();
        }

        public int Count(Expression<Func<T, bool>> filter = null)
        {
            IQueryable<T> query = Items;

            if (filter != null)
                query = query.Where(filter);

            return query.Count();
        }

        public void Save(T item)
        {
            if (item.Id > 0)
                Items.Update(item);
            else
                Items.Add(item);

            Context.SaveChanges();
        }

        public void Delete(T item)
        {
            Items.Remove(item);
            Context.SaveChanges();
        }
    }
}
