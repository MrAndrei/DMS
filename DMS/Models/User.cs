using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace DMS.Models
{
    public class User
    {
        public int id { get; set; }

        [Required]
        [StringLength(50, MinimumLength = 3)]
        public string name { get; set; }

        [StringLength(50, MinimumLength = 3)]
        public string role { get; set; }

        [StringLength(50, MinimumLength = 2)]
        public string location { get; set; }

        [Required]
        [StringLength(50, MinimumLength = 3)]
        public string username { get; set; }

        [Required]
        [StringLength(50, MinimumLength = 6)]
        public string password { get; set; }

        public User(int id) {
            this.id = id;
        }

        public User(int id, string name) {
            this.id   = id;
            this.name = name;
        }

        public User(string name, string role, string location, string username, string password) {
            this.name     = name;
            this.role     = role;
            this.location = location;
            this.username = username;
            this.password = password;
        }
    }
}
