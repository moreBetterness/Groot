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

            List<Message> alldata = StorageTableDB.GetAllData();
            int[] test2 = new int[40];
            for (int i = 0; i <= 39; i++)
            {
                test2[i] = Convert.ToInt32(alldata[i].@event);
            }
            ViewBag.Wetness = test2;
            return View(model);
        }

        public ActionResult Graph()
        {
            List<Message> alldata = StorageTableDB.GetAllData();
            int[] test2 = new int[40];
            for (int i = 0; i <= 39; i++)
            {
                test2[i] = Convert.ToInt32(alldata[i].@event);
            }
            ViewBag.Wetness = test2;
            return View();
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