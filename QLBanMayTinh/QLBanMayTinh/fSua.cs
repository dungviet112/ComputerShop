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
    public partial class fSua : Form
    {
        SqlConnection con;
        public fSua()
        {
            InitializeComponent();
        }

        private void fSua_Load(object sender, EventArgs e)
        {
            string conString = @"Data Source=MSI\SQLEXPRESS;Initial Catalog=QLBanMayTinh;Integrated Security=True";
            con = new SqlConnection(conString);
            con.Open();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string sqlEDIT = "UPDATE COMPUTER SET TenMay = @TenMay , MaLoai = @MaLoai, MaChip = @MaChip,MaOCung = @MaOCung, MaMH = @MaMH,MaChuot = @MaChuot, MaBP = @MaBP,MaRam = @MaRam, MaLoa = @MaLoa,MaHangSX = @MaHangSX, ThoiGianBH = @ThoiGianBH,GhiChu = @GhiChu WHERE MaMay = @MaMay";
            SqlCommand cmd = new SqlCommand(sqlEDIT, con);
            cmd.Parameters.AddWithValue("@MaMay", tbMaMay.Text);
            cmd.Parameters.AddWithValue("@TenMay", tbTenMay.Text);
            cmd.Parameters.AddWithValue("@MaLoai", tbMaLoai.Text);
            cmd.Parameters.AddWithValue("@MaChip", tbMaChip.Text);
            cmd.Parameters.AddWithValue("@MaOCung", tbMaOCung.Text);
            cmd.Parameters.AddWithValue("@MaMH", tbMaMH.Text);
            cmd.Parameters.AddWithValue("@MaChuot", tbMaChuot.Text);
            cmd.Parameters.AddWithValue("@MaBP", tbMaBP.Text);
            cmd.Parameters.AddWithValue("@MaRam", tbMaRam.Text);
            cmd.Parameters.AddWithValue("@MaLoa", tbMaLoa.Text);
            cmd.Parameters.AddWithValue("@MaHangSX", tbMaHangSX.Text);
            cmd.Parameters.AddWithValue("@ThoiGianBh", tbTGBH.Text);
            cmd.Parameters.AddWithValue("@GhiChu", tbGhiChu.Text);
            cmd.ExecuteNonQuery();
            this.Close();
        }
    }
}
