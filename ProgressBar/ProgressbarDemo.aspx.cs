using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProgressBar
{
    public partial class ProgressbarDemo : System.Web.UI.Page
    {
        public static int ProgressValue = 0;
        public static string ProcessingMessage = "test";
        public static string DetailedMessage = "test2";
        protected void Page_Load(object sender, EventArgs e)
        {
            GiveProgressStatus();
        }

        private void GiveProgressStatus()
        {
            if (Request.HttpMethod == "POST" && Request.QueryString["GetProgress"] != null)
            {
                Response.Clear();
                Response.ContentType = "application/json";
                string progress = ProgressValue.ToString();               

                string response = "{\"progress\":" + progress + "," + Environment.NewLine +
                "\"ProcessingMessage\":" + "\"" + ProcessingMessage + "\"" + "," +
                "\"DetailedMessage\":" + "\"" + DetailedMessage + "\"" + "}";


                Response.Write(response);

                Response.End();
            }
        }

        protected void btnAutoMerge_Click(object sender, EventArgs e)
        {
            Thread t = new Thread(UpdateProgressValue);
            t.Start();
            //run javascript method requestNewProgress()            
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "requestNewProgress", "requestNewProgress()", true);
        }

        protected void UpdateProgressValue()
        {
            //Long process goes in here
            for(int i=0; i<=100;i++)
            {
                System.Threading.Thread.Sleep(100);
                ProcessingMessage = "Processsing " + i.ToString() + " of 100" ;
                DetailedMessage = Guid.NewGuid().ToString();
                ProgressValue = i;
            }

        }
    }
}