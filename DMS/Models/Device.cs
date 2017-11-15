using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace DMS.Models
{
    public class Device
    {
        public int id { get; set; }

        [Required]
        [StringLength(50, MinimumLength = 3)]
        public string name { get; set; }

        [StringLength(30, MinimumLength = 2)]
        public string manufacturer { get; set; }

        public enum DeviceType
        {
            [Display(Name = "Phone")]
            FirstValue,
            [Display(Name = "Tablet")]
            SecondValue
        }
        [EnumDataType(typeof(DeviceType))]
        [Required]
        public string type { get; set; }

        [StringLength(50)]
        public string os { get; set; }


        public double os_version { get; set; }

        [StringLength(50)]
        public string cpu { get; set; }

        [StringLength(10)]
        public string ram { get; set; }

        public Device() { }

        public Device(int id, string name, string manufacturer, string type, string os, double os_version, string cpu, string ram) {
            this.id = id;
            this.name = name;
            this.manufacturer = manufacturer;
            this.type = type;
            this.os = os;
            this.os_version = os_version;
            this.cpu = cpu;
            this.ram = ram;
        }
    }
}
