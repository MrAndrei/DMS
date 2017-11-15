using System;
using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc;
using System.Data.SqlClient;
using DMS.Models;

namespace DMS.Controllers
{
    public class DMSController : Controller
    {
        /*
         * Initialize connection with the string needed to connect to the database
         */
        static SqlConnection con = new SqlConnection("Data Source=.\\SQLEXPRESS01;Initial Catalog=Devices;Integrated Security=True");

        static SqlCommand cmd;
        static SqlDataReader reader;
        static Device d1;
        static User u1;
        public static string user_name;
        static int id;
        static List<Object[]> deviceList = new List<Object[]>();


        /*
         * This method checks if the user is logged in by verifying a cookie. If the cookie is set,
         * the user will be redirected to the home page. Else, he will be redirected to the login page.
         */
        public IActionResult LoginPage() {
            if (Request.Cookies.ContainsKey("user_logged_in"))
            {
                LoadDevices(deviceList);
                return View("Index", deviceList);
            }
            else
                return View("Login");
        } 


        /*
         *  This is the method which will be triggered when the user submits the login form. A check to the database is made 
         *  with the username and the password provided by the user. The password is hashed and compared to the one from the db, 
         *  which is also hashed...for security reasons. If the user is found, he will be redirected to the home page and all of the
         *  devices will be loaded. Also, some cookies are stored locally to enable the system to know which user is currently logged in. 
         */ 
        [HttpPost]
        public IActionResult Login(string username, string password) {
            deviceList.Clear();
            string hashed_password = Hash.HashPassword(password);
            if (con.State == System.Data.ConnectionState.Closed)
                con.Open();
            cmd = new SqlCommand($"select * from Users where username='{username}' and password='{hashed_password}'",con);
            reader = cmd.ExecuteReader();
            if (reader.HasRows)
            {
                reader.Read();
                u1 = new User(reader.GetInt32(0));
                SetUserName(reader.GetString(1));
                reader.Close();
                LoadDevices(deviceList);
                

                Response.Cookies.Append("user_logged_in","OK");
                Response.Cookies.Append("user_id", u1.id.ToString());

                
                con.Close();
                return View("Index",deviceList);
            }
            else
            {
                reader.Close();
                con.Close();
                return View("404");
            }
        }

        [NonAction]
        public void SetUserName(string username) {
            user_name = username;
        }

        /*
         *   This method is called when the user signs out. All the cookies are deleted and he is redirected to the login page.
         */ 
        [ActionName("SignOut")]
        public void Logout() {
            Response.Cookies.Delete("user_logged_in");
            Response.Cookies.Delete("user_id");
            user_name = string.Empty;
            Response.Redirect("http://localhost:61759/");
        }

        /*
         *   This method is called from different views (details, create, edit view) to return to the home page (index) 
         */
        [ActionName("Home")]
        public IActionResult BackToIndex() {
            deviceList.Clear();
            if (Request.Cookies.ContainsKey("user_logged_in"))
            {
                LoadDevices(deviceList);
                return View("Index", deviceList);
            }
            else
                return View("NotLogged");
        }

        /*
         *  This methods calls the view which prints more details about a specific device.
         */
        public IActionResult Details(int id)
        {
            if (Request.Cookies.ContainsKey("user_logged_in"))
            {
                d1 = SelectDevice(d1, id);
                return View(d1);
            }
            return View("NotLogged");
        }

        /*
         *  This method calls the create device view.
         */
        [ActionName("Create")]
        public IActionResult CreateDevice() {
            if (Request.Cookies.ContainsKey("user_logged_in"))
                return View();
            return View("NotLogged");
        }

        [ActionName("Edit")]
        public IActionResult EditDevice(int id, string name, string manufacturer,
                                        string type, string os, float os_version,
                                        string cpu, string ram) {
            if (Request.Cookies.ContainsKey("user_logged_in"))
            {
                ViewBag.id = id;
                ViewBag.name = name;
                ViewBag.manufacturer = manufacturer;
                ViewBag.type = type;
                ViewBag.os = os;
                ViewBag.os_version = os_version;
                ViewBag.cpu = cpu;
                ViewBag.ram = ram;

                return View();
            }
            return View("NotLogged");
        }

        

        [NonAction]
        public void LoadDevices(List<Object[]> devices) {
                var obj = new object[5];
                if (con.State == System.Data.ConnectionState.Closed)
                    con.Open();
                string query = @"select Devices.id, Devices.name,u1.name as Owner,u2.name as [Current_User], u2.id from Devices 
                                left join Ownership on Devices.id = id_device
                                left join Users u1 on u1.id = id_owner
                                left join Users u2 on u2.id = [current_user]";
                cmd = new SqlCommand(query, con);
                reader = cmd.ExecuteReader();
                while (reader.Read())
                {

                    if (!reader.IsDBNull(3))
                        obj = new object[] { reader.GetInt32(0), reader.GetString(1), reader.GetString(2), reader.GetString(3) };
                    else
                            if (reader.IsDBNull(3))
                                if (reader.IsDBNull(2))
                                    obj = new object[] { reader.GetInt32(0), reader.GetString(1), "", "" };
                                else
                                    obj = new object[] { reader.GetInt32(0), reader.GetString(1), reader.GetString(2), "" };

                    devices.Add(obj);
                }
                reader.Close();
                con.Close();

        }

        /*
           selects a device from the db based on id 
       */
        [NonAction]
        public Device SelectDevice(Device d1, int id)
        {
            if (con.State == System.Data.ConnectionState.Closed)
                con.Open();
            cmd = new SqlCommand("select * from Devices where id=" + id, con);
            reader = cmd.ExecuteReader();
            if (reader.Read())
                d1 = new Device(reader.GetInt32(0), reader.GetString(1), reader.GetString(2), reader.GetString(3),
                                    reader.GetString(4), reader.GetDouble(5), reader.GetString(6), reader.GetString(7));
            reader.Close();
            con.Close();
            return d1;
        }


        /*
            Insert a new device in the databse
        */
        [ActionName("InsertDevice")]
        public void InsertDevice(string name, string manufacturer,
                                        string type, string os, float os_version,
                                        string cpu, string ram)
        {
           
            if (Request.Cookies.ContainsKey("user_logged_in"))
            {
                if (con.State == System.Data.ConnectionState.Closed)
                    con.Open();
                cmd = new SqlCommand($"insert into Devices values('{name}','{manufacturer}','{type}','{os}','{os_version}','{cpu}','{ram}')", con);
                if (cmd.ExecuteNonQuery() != 0)
                {
                    cmd = new SqlCommand($"select id from Devices where name='{name}'",con);
                    reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        reader.Read();
                        id = reader.GetInt32(0);
                    }
                    reader.Close();
                    cmd = new SqlCommand($"insert into Ownership(id_device,id_owner) values({id},1)",con);
                    if (cmd.ExecuteNonQuery() != 0)
                    {
                        con.Close();
                        Response.Redirect("http://localhost:61759/dms/Home");
                    }
                }
            }
            else
                Response.Redirect("http://localhost:61759/");

        }

        /*
            Update a device in the database
        */
        [ActionName("UpdateDevice")]
        public void UpdateDevice(int id, string name, string manufacturer,
                                        string type, string os, float os_version,
                                        string cpu, string ram){
            if (Request.Cookies.ContainsKey("user_logged_in"))
            {
                if (con.State == System.Data.ConnectionState.Closed)
                    con.Open();
                cmd = new SqlCommand($"update Devices set name='{name}',manufacturer='{manufacturer}',type='{type}',os='{os}',os_version='{os_version}',cpu='{cpu}',ram='{ram}'" +
                    $"where id={id}", con);
                if (cmd.ExecuteNonQuery() != 0)
                {

                    con.Close();
                    Response.Redirect("http://localhost:61759/dms/Details/"+$"{id}");
                }
            }
            else
                Response.Redirect("http://localhost:61759/");
        }

        /*
            Delete record from database based on id 
        */

        [ActionName("Delete")]
        public void DeleteDevice(int id)
        {
            if (Request.Cookies.ContainsKey("user_logged_in"))
            {
                if (con.State == System.Data.ConnectionState.Closed)
                    con.Open();
                cmd = new SqlCommand($"delete from Devices where id='{id}' ", con);
                if (cmd.ExecuteNonQuery() != 0)
                {
                    con.Close();
                    Response.Redirect("http://localhost:61759/dms/Home");
                }
            }
            else
                Response.Redirect("http://localhost:61759/");
        }

        /*
         *  Assign device to a user logged in. Only the devices which do not have a current user have this option.
         */
        public void AssignDevice(string device_id) {
            if (Request.Cookies.ContainsKey("user_logged_in"))
            {
                string user_id = "";
                Request.Cookies.TryGetValue("user_id",out user_id);

                if (con.State == System.Data.ConnectionState.Closed)
                    con.Open();
                cmd = new SqlCommand($"update Ownership set [current_user]={int.Parse(user_id)} where id_device={int.Parse(device_id)}",con);
                    if (cmd.ExecuteNonQuery() != 0) {
                        con.Close();
                        Response.Redirect("http://localhost:61759/dms/Home");
                    }     
            }
            else
                Response.Redirect("http://localhost:61759/");

        }

        /*
         *   Unassign a device for a user who owns the respective device. 
         */
        public void UnassignDevice(string device_id) {
            if (Request.Cookies.ContainsKey("user_logged_in"))
            {
                string user_id = "";
                Request.Cookies.TryGetValue("user_id", out user_id);

                if (con.State == System.Data.ConnectionState.Closed)
                    con.Open();
                cmd = new SqlCommand($"update Ownership set [current_user]=null where id_device={int.Parse(device_id)}", con);
                if (cmd.ExecuteNonQuery() != 0)
                {
                    con.Close();
                    Response.Redirect("http://localhost:61759/dms/Home");
                }
            }
            else
                Response.Redirect("http://localhost:61759/");

        }
    }
}
