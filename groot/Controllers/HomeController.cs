using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using groot.Models;

namespace groot.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            //List<StorageTables> model = StorageTableDB.GetAllData();
            Message model = StorageTableDB.GetData();
            return View(model);
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
    }
}