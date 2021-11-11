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
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }
        SqlConnection con;
        
        private void Form1_Load(object sender, EventArgs e)
        {
            string conString = @"Data Source=MSI\SQLEXPRESS;Initial Catalog=QLBanMayTinh;Integrated Security=True";
            con = new SqlConnection(conString);
            con.Open();
            HienThi();
        }
        public void HienThi()
        {
            string sqlSELECT = "select * from COMPUTER";
            SqlCommand cmd = new SqlCommand(sqlSELECT, con);
            SqlDataReader dr = cmd.ExecuteReader();
            DataTable dt = new DataTable();
            dt.Load(dr);
            dataGridView1.DataSource = dt;
        }

        private void btnThemMoi_Click(object sender, EventArgs e)
        {
            fThemMoi tm = new fThemMoi();
            tm.ShowDialog();
        }

        private void btnSua_Click(object sender, EventArgs e)
        {
            fSua Sua = new fSua();
            Sua.ShowDialog();
        }

        private void btnXoa_Click(object sender, EventArgs e)
        {
            fXoa Xoa = new fXoa();
            Xoa.ShowDialog();   
        }

        private void btnIn_Click(object sender, EventArgs e)
        {
            FormReport rp = new FormReport();
            rp.ShowDialog();
        }

        private void btnTimKiem_Click(object sender, EventArgs e)
        {
            fTimKiem ftimkiem = new fTimKiem();
            ftimkiem.ShowDialog();
        }

        private void btnXem_Click(object sender, EventArgs e)
        {
            HienThi();
        }

        private void btCOMPUTER_Click(object sender, EventArgs e)
        {
            HienThi();
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            var table = (string)this.comboBox1.SelectedItem;
            string sqlSELECT = $"select * from {table}";
            SqlCommand cmd = new SqlCommand(sqlSELECT, con);
            SqlDataReader dr = cmd.ExecuteReader();
            DataTable dt = new DataTable();
            dt.Load(dr);
            dataGridView1.DataSource = dt;
        }
    }
}
