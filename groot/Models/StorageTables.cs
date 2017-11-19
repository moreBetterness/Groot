using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Helpers;
using Microsoft.WindowsAzure.Storage.Table;
using System.Configuration;
using System.Linq.Expressions;
using System.Runtime.Serialization;
using System.Web.Script.Serialization;
using System.Web.Services.Description;
using Microsoft.Azure;
using Microsoft.WindowsAzure;
using Microsoft.WindowsAzure.Storage;

namespace groot.Models
{
    public class Message:IComparable<Message>
    {
        public String @event { get; set; }
        public String data { get; set; }
        public String published_at { get; set; }
        public String coreid { get; set; }
        public String device_id { get; set; }
        public String eventName { get; set; }

        public int CompareTo(Message other)
        {
            DateTime tpub = Convert.ToDateTime(this.published_at);
            DateTime opub = Convert.ToDateTime(other.published_at);

            if (tpub < opub)
            {
                return 1;
            }
            else if (tpub == opub)
            {
                return 0;
            }
            else
            {
                return -1;
            }
        }
    }
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
        public DateTime OurDateTime { get; set; }
    }
    public static class StorageTableDB
    {
        public static Message GetData()
        {
            string connStr = ConfigurationManager.ConnectionStrings["StorageConnectionString"].ConnectionString;
            CloudStorageAccount storageAccount = CloudStorageAccount.Parse(connStr);
            CloudTableClient client = storageAccount.CreateCloudTableClient();
            CloudTable table = client.GetTableReference("sensordata");
            TableQuery<StorageTables> queryOperation = new TableQuery<StorageTables>();
            TableQuery<StorageTables> query = new TableQuery<StorageTables>().Where(TableQuery.GenerateFilterCondition("PartitionKey", QueryComparisons.Equal, "0"));
            DateTimeOffset maxTimeStamp = DateTimeOffset.MinValue;
            StorageTables currentMessage = new StorageTables();
            foreach (StorageTables entity in table.ExecuteQuery(query))
            {
                if (entity.Timestamp > maxTimeStamp)
                {
                    maxTimeStamp = entity.Timestamp;
                    currentMessage = entity;
                }
            }
            Message mess = new JavaScriptSerializer().Deserialize<Message>(currentMessage.Message);
            mess.eventName = mess.@event;
            return mess;
        }
        public static List<Message> GetAllData()
        {
            string connStr = ConfigurationManager.ConnectionStrings["StorageConnectionString"].ConnectionString;
            CloudStorageAccount storageAccount = CloudStorageAccount.Parse(connStr);
            CloudTableClient client = storageAccount.CreateCloudTableClient();
            CloudTable table = client.GetTableReference("sensordata");
            table.CreateIfNotExists();

            List<StorageTables> output = new List<StorageTables>();

            TableQuery<StorageTables> query = new TableQuery<StorageTables>().Where(TableQuery.GenerateFilterCondition("PartitionKey", QueryComparisons.Equal, "0"));
            List<Message> sortMessage = new List<Message>();

            foreach (StorageTables entity in table.ExecuteQuery(query))
            {
                try
                {
                    Message mess = new JavaScriptSerializer().Deserialize<Message>(entity.Message);

                    if (mess.@event == "HIGH")
                    {
                        mess.@event = "3";
                    }
                    else if (mess.@event == "MEDIUM")
                    {
                        mess.@event = "2";
                    }
                    else
                    {
                        mess.@event = "1";
                    }
                    sortMessage.Add(mess);
                    //output.Add(new StorageTables()
                    //{
                    //    Message = mess.@event,
                    //    Timestamp = entity.Timestamp
                    //});
                    //Console.WriteLine(entity.PartitionKey, entity.RowKey, entity.Message);
                    sortMessage.Sort();
                }
                catch (Exception ex) { }

            }


            return sortMessage;

            //TableOperation retOp = TableOperation.Retrieve<StorageTables>("0", "0013e96a-320e-4224-86c9-9e9f630e0cd9");
            //TableResult tr = table.Execute(retOp);
            //return tr.Result as StorageTables;
        }
    }
}