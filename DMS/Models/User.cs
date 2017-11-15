using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DMS.Models
{
    public class User
    {
        public int id { get; set; }
        private string name { get; set; }
        private string role { get; set; }
        private string location { get; set; }
        private string username { get; set; }
        private string password { get; set; }

        public User(int id) {
            this.id = id;
        }

        public User(int id, string name) {
            this.id   = id;
            this.name = name;
        }
    }
}
