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
    public partial class fTimKiem : Form
    {
        SqlConnection con;
        public fTimKiem()
        {
            InitializeComponent();
        }

        private void fTimKiem_Load(object sender, EventArgs e)
        {
            string conString = @"Data Source=MSI\SQLEXPRESS;Initial Catalog=QLBanMayTinh;Integrated Security=True";
            con = new SqlConnection(conString);
            con.Open();
            comboBox1.Items.Add("1.Doanh thu năm 2021");
            comboBox1.Items.Add("2.Khách hàng tháng 10/2021");
            comboBox1.Items.Add("3.Nhân viên có quê Thanh Hóa");
            comboBox1.Items.Add("4.Quà tặng khi mua số lượng lớn");
            comboBox1.Items.Add("5.Tiền lãi");
            comboBox1.Items.Add("6.Tổng tiền hóa đơn bán");
            comboBox1.Items.Add("7.Tổng tiền hóa đơn nhập");
            comboBox1.Items.Add("8.Top 2 sản phẩm bán ít nhất");
            comboBox1.Items.Add("9.Nhập sản phẩm từ nhà cung cấp nhiều nhất");

            comboBox1.Items.Add("10.Thông tin nhân viên có mã nhân viên là NV2");
            comboBox1.Items.Add("11.Thông tin hóa đơn theo mã HDB là HDB1");
            comboBox1.Items.Add("12.Số nhân viên đến từ Thanh Hóa");
            comboBox1.Items.Add("13.Thời gian bảo hành theo mã khách hàng (KH1) và mã máy (MM1)");
            comboBox1.Items.Add("14.Những máy được nhập từ NCC có mã là NCC1");
            comboBox1.Items.Add("15.Những máy sử dụng Chip có mã là C1");

            comboBox1.Items.Add("16.Số tiền cần thanh toán của HDB2");
            comboBox1.Items.Add("17.Xóa các hóa đơn mà không có chi tiết hóa đơn");
            comboBox1.Items.Add("18.Doanh thu của ngày 21/2/2021");
            comboBox1.Items.Add("19.Tổng số hóa đơn đã lập và tổng doanh thu đã bán hàng của một nhân viên 4 trong năm 2021");
            comboBox1.Items.Add("20.Tính tuổi của NV5");
            comboBox1.Items.Add("21.Tổng số lượng và tổng số tiền đã nhập");
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (comboBox1.SelectedIndex == 0)
            {
                string sqlSELECT = "select * from DOANHTHU2021";
                SqlCommand cmd = new SqlCommand(sqlSELECT, con);
                SqlDataReader dr = cmd.ExecuteReader();
                DataTable dt = new DataTable();
                dt.Load(dr);
                dataGridView1.DataSource = dt;
            }
            if (comboBox1.SelectedIndex == 1)
            {
                string sqlSELECT = "select * from KH_Thang10_2021";
                SqlCommand cmd = new SqlCommand(sqlSELECT, con);
                SqlDataReader dr = cmd.ExecuteReader();
                DataTable dt = new DataTable();
                dt.Load(dr);
                dataGridView1.DataSource = dt;
            }
            if (comboBox1.SelectedIndex == 2)
            {
                string sqlSELECT = "select * from NV_ThanhHoa";
                SqlCommand cmd = new SqlCommand(sqlSELECT, con);
                SqlDataReader dr = cmd.ExecuteReader();
                DataTable dt = new DataTable();
                dt.Load(dr);
                dataGridView1.DataSource = dt;
            }
            if (comboBox1.SelectedIndex == 3)
            {
                string sqlSELECT = "select * from QUATANG";
                SqlCommand cmd = new SqlCommand(sqlSELECT, con);
                SqlDataReader dr = cmd.ExecuteReader();
                DataTable dt = new DataTable();
                dt.Load(dr);
                dataGridView1.DataSource = dt;
            }
            if (comboBox1.SelectedIndex == 4)
            {
                string sqlSELECT = "select * from TienLai";
                SqlCommand cmd = new SqlCommand(sqlSELECT, con);
                SqlDataReader dr = cmd.ExecuteReader();
                DataTable dt = new DataTable();
                dt.Load(dr);
                dataGridView1.DataSource = dt;
            }
            if (comboBox1.SelectedIndex == 5)
            {
                string sqlSELECT = "select * from TongTienHDB";
                SqlCommand cmd = new SqlCommand(sqlSELECT, con);
                SqlDataReader dr = cmd.ExecuteReader();
                DataTable dt = new DataTable();
                dt.Load(dr);
                dataGridView1.DataSource = dt;
            }
            if (comboBox1.SelectedIndex == 6)
            {
                string sqlSELECT = "select * from TongTienHDN";
                SqlCommand cmd = new SqlCommand(sqlSELECT, con);
                SqlDataReader dr = cmd.ExecuteReader();
                DataTable dt = new DataTable();
                dt.Load(dr);
                dataGridView1.DataSource = dt;
            }
            if (comboBox1.SelectedIndex == 7)
            {
                string sqlSELECT = "select * from TOP2SPBANITNHAT";
                SqlCommand cmd = new SqlCommand(sqlSELECT, con);
                SqlDataReader dr = cmd.ExecuteReader();
                DataTable dt = new DataTable();
                dt.Load(dr);
                dataGridView1.DataSource = dt;
            }
            if (comboBox1.SelectedIndex == 8)
            {
                string sqlSELECT = "select * from TopNCC";
                SqlCommand cmd = new SqlCommand(sqlSELECT, con);
                SqlDataReader dr = cmd.ExecuteReader();
                DataTable dt = new DataTable();
                dt.Load(dr);
                dataGridView1.DataSource = dt;
            }
            if (comboBox1.SelectedIndex == 9)
            {
                string sqlSELECT = "select * from ThongTin_NV('NV2')";
                SqlCommand cmd = new SqlCommand(sqlSELECT, con);
                SqlDataReader dr = cmd.ExecuteReader();
                DataTable dt = new DataTable();
                dt.Load(dr);
                dataGridView1.DataSource = dt;
            }
            if (comboBox1.SelectedIndex == 10)
            {
                string sqlSELECT = "select * from ThongTinHD ('HDB1')";
                SqlCommand cmd = new SqlCommand(sqlSELECT, con);
                SqlDataReader dr = cmd.ExecuteReader();
                DataTable dt = new DataTable();
                dt.Load(dr);
                dataGridView1.DataSource = dt;
            }
            if (comboBox1.SelectedIndex == 11)
            {
                string sqlSELECT = "select * from QueQuan_NV('Thanh Hoá')";
                SqlCommand cmd = new SqlCommand(sqlSELECT, con);
                SqlDataReader dr = cmd.ExecuteReader();
                DataTable dt = new DataTable();
                dt.Load(dr);
                dataGridView1.DataSource = dt;
            }
            if (comboBox1.SelectedIndex == 12)
            {
                string sqlSELECT = "select * from TGBH('KH1','MM1')";
                SqlCommand cmd = new SqlCommand(sqlSELECT, con);
                SqlDataReader dr = cmd.ExecuteReader();
                DataTable dt = new DataTable();
                dt.Load(dr);
                dataGridView1.DataSource = dt;
            }
            if (comboBox1.SelectedIndex == 13)
            {
                string sqlSELECT = "select * from MayTu_NCC('NCC1')";
                SqlCommand cmd = new SqlCommand(sqlSELECT, con);
                SqlDataReader dr = cmd.ExecuteReader();
                DataTable dt = new DataTable();
                dt.Load(dr);
                dataGridView1.DataSource = dt;
            }
            if (comboBox1.SelectedIndex == 14)
            {
                string sqlSELECT = "select * from MaySD_Chip('C1')";
                SqlCommand cmd = new SqlCommand(sqlSELECT, con);
                SqlDataReader dr = cmd.ExecuteReader();
                DataTable dt = new DataTable();
                dt.Load(dr);
                dataGridView1.DataSource = dt;
            }
            if (comboBox1.SelectedIndex == 15)
            {
                string sqlSELECT = "exec SoHoaDon 'HDB2'";
                SqlCommand cmd = new SqlCommand(sqlSELECT, con);
                SqlDataReader dr = cmd.ExecuteReader();
                DataTable dt = new DataTable();
                dt.Load(dr);
                dataGridView1.DataSource = dt;
            }
            if (comboBox1.SelectedIndex == 16)
            {
                string sqlSELECT = "exec XoaHD";
                SqlCommand cmd = new SqlCommand(sqlSELECT, con);
                SqlDataReader dr = cmd.ExecuteReader();
                DataTable dt = new DataTable();
                dt.Load(dr);
                dataGridView1.DataSource = dt;
            }
            if (comboBox1.SelectedIndex == 17)
            {
                string sqlSELECT = "exec DoanhThu_Ngay '2021-02-20'";
                SqlCommand cmd = new SqlCommand(sqlSELECT, con);
                SqlDataReader dr = cmd.ExecuteReader();
                DataTable dt = new DataTable();
                dt.Load(dr);
                dataGridView1.DataSource = dt;
            }
            if (comboBox1.SelectedIndex == 18)
            {
                string sqlSELECT = "declare @t int, @dt int exec TongHDDT '2021', 'NV4', @t output, @dt output print @t print @dt";
                SqlCommand cmd = new SqlCommand(sqlSELECT, con);
                SqlDataReader dr = cmd.ExecuteReader();
                DataTable dt = new DataTable();
                dt.Load(dr);
                dataGridView1.DataSource = dt;
            }
            if (comboBox1.SelectedIndex == 19)
            {
                string sqlSELECT = "declare @h int exec TinhTuoi 'NV5',@h output";
                SqlCommand cmd = new SqlCommand(sqlSELECT, con);
                SqlDataReader dr = cmd.ExecuteReader();
                DataTable dt = new DataTable();
                dt.Load(dr);
                dataGridView1.DataSource = dt;
            }
            if (comboBox1.SelectedIndex == 20)
            {
                string sqlSELECT = "exec TongNhap 'MM3'";
                SqlCommand cmd = new SqlCommand(sqlSELECT, con);
                SqlDataReader dr = cmd.ExecuteReader();
                DataTable dt = new DataTable();
                dt.Load(dr);
                dataGridView1.DataSource = dt;
            }
        }
    }
}
