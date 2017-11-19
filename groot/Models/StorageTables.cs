using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Helpers;
using Microsoft.WindowsAzure.Storage.Table;
using System.Configuration;
using Microsoft.Azure;
using Microsoft.WindowsAzure;
using Microsoft.WindowsAzure.Storage;

namespace groot.Models
{
    public class StorageTables : TableEntity
    {
        

        public StorageTables()
        {
        }

        public StorageTables(string message)
        {
            
            Message = "Test";
            PartitionKey = "1";
            RowKey = "Test";

        }
        public string Message { get; set; }
    }
    public static class StorageTableDB
    {
        public static string GetData()
        {
            try
            {
                string connStr = ConfigurationManager.ConnectionStrings["StorageConnectionString"].ConnectionString;
                CloudStorageAccount storageAccount = CloudStorageAccount.Parse(connStr);
                CloudTableClient client = storageAccount.CreateCloudTableClient();
                CloudTable table = client.GetTableReference("sensordata");
                TableQuery<StorageTables> queryOperation = new TableQuery<StorageTables>();

                return table.Uri.ToString();
            }
            catch (Exception ex)
            {
            }

            return "it did not work";
        }
        public static string RetrieveEmployee()
        {
            string connStr = ConfigurationManager.ConnectionStrings["StorageConnectionString"].ConnectionString;
            CloudStorageAccount storageAccount = CloudStorageAccount.Parse(connStr);
            CloudTableClient client = storageAccount.CreateCloudTableClient();
            CloudTable table = client.GetTableReference("sensordata");
            table.CreateIfNotExists();


            TableQuery<StorageTables> query = new TableQuery<StorageTables>().Where(TableQuery.GenerateFilterCondition("PartitionKey", QueryComparisons.Equal, "0"));
            foreach (StorageTables entity in table.ExecuteQuery(query))
            {
                Console.WriteLine(entity.PartitionKey, entity.RowKey, entity.Message);
            }

            return "sdaf";

            //TableOperation retOp = TableOperation.Retrieve<StorageTables>("0", "0013e96a-320e-4224-86c9-9e9f630e0cd9");
            //TableResult tr = table.Execute(retOp);
            //return tr.Result as StorageTables;
        }
    }
}