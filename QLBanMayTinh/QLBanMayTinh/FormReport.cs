using Microsoft.Reporting.WinForms;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QLBanMayTinh
{
    public partial class FormReport : Form
    {
        public FormReport()
        {
            InitializeComponent();
        }
        SqlConnection con;
        private void FormReport_Load(object sender, EventArgs e)
        {
            string conString = @"Data Source=MSI\SQLEXPRESS;Initial Catalog=QLBanMayTinh;Integrated Security=True";
            con = new SqlConnection(conString);
            con.Open();

            String sql;
            sql = "SELECT * from COMPUTER";
            SqlDataAdapter dataAdapter = new SqlDataAdapter(sql, con);
            DataTable dt = new DataTable();
            dataAdapter.Fill(dt);
            con.Close();

            reportViewer1.LocalReport.ReportEmbeddedResource = "QLBanMayTinh.Report1.rdlc";
            ReportDataSource rds = new ReportDataSource();
            rds.Name = "DataCOMPUTER";
            rds.Value = dt;
            reportViewer1.LocalReport.DataSources.Add(rds);
            this.reportViewer1.RefreshReport();
        }
    }
}
