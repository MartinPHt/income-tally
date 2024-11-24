using System.ComponentModel.DataAnnotations;

namespace Common.Entities
{
    public abstract class BaseEntity
    {
        [Key]
        public int Id { get; set; }
    }
}
