using ExemploWindows.Dominio;
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
using Dapper;
using MySql.Data.MySqlClient;

namespace ExemploWindows
{
    public partial class frmPrincipal : Form
    {
        private SqlConnection conexao;
        private List<Editora> editoras;
        Editora novaEditora;
        public frmPrincipal()
        {
            InitializeComponent();
            conexao = new SqlConnection("data source=(local); initial catalog=aceleradev; integrated security=true;");
        }

        private void btnCarregar_Click(object sender, EventArgs e)
        {
            editoras = conexao.Query<Editora>("select id,nome,endereco,numero from editora").ToList();
            bindingSourceEditora.DataSource = editoras;
        }

        private void btnGravar_Click(object sender, EventArgs e)
        {
            if (novaEditora == null)
            {
                conexao.Execute("update editora set nome = @nome, endereco = @endereco, numero = @numero where id = @id",
                    new { nome = txtNome.Text, endereco = txtEndereco.Text, numero = txtNumero.Text, id = int.Parse(txtID.Text) });
            }
            else
            {
                conexao.Execute("insert into editora(nome,endereco,numero) values(@nome,@endereco,@numero)",
                    new { nome = txtNome.Text, endereco = txtEndereco.Text, numero = txtNumero.Text});
                novaEditora = null;
                btnCarregar_Click(sender, e);
            }
        }

        private void btnIncluir_Click(object sender, EventArgs e)
        {
            novaEditora = new Editora();
            bindingSourceEditora.DataSource = novaEditora;
        }

        private void btnExcluir_Click(object sender, EventArgs e)
        {
            if(txtID.Text == "")
            {
                return;
            }

            if (MessageBox.Show("Confirma a exclusão?", "Atenção", MessageBoxButtons.OKCancel) == DialogResult.OK)
            {
                conexao.Execute("delete from editora where id = @id", new { id = int.Parse(txtID.Text) });
                MessageBox.Show("Editora Excluída!");
                btnCarregar_Click(sender, e);
            }
        }
    }
}
