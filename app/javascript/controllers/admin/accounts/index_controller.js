import DatatablesController from '../../datatables_controller';

export default class extends DatatablesController {
  datatableColumns(){
    return [
      {
        field: 'index',
        title: '#',
        sortable: false,
        width: 40,
        type: 'number',
        selector: false,
        textAlign: 'left',
        template: function(data) {
          return `<span class="font-weight-bolder">${data.index}</span>`;
        }
      },
      {
        field: 'code',
        title: 'Kode Akun',
        width: 100,
        template: function(data) {
          return `<span class="font-weight-bolder">${data.code}</span>`;
        }
      },
      {
        field: 'name',
        title: 'Nama Akun',
        template: function(data) {
          return `<span class="font-weight-bolder">${data.name}</span>`;
        }
      },
      {
        field: 'balance_type',
        title: 'Tipe Akun',
        width: 80,
        textAlign: 'center',
        template: function(data) {
          return `<span class="font-weight-bolder">${data.balance_type}</span>`;
        }
      },      
      {
        field: 'Actions',
        title: 'Actions',
        sortable: false,
        width: 100,
        overflow: 'visible',
        autoHide: false,
        template: function(data) {
          return `
            <a href="${data.edit_partial_path}" class="btn btn-sm btn-clean btn-icon">
              <i class="la la-edit"></i>
            </a>
            <a href="${data.delete_path}" data-method="delete" data-confirm="Apakah anda yakin ingin menghapus akun ini?" class="btn btn-sm btn-clean btn-icon" title="Delete">
              <i class="la la-trash text-danger"></i>
            </a>
          `;
        },
      }
    ]
  }
}
