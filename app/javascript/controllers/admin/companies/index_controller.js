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
        field: 'name',
        title: 'Nama',
        template: function(data) {
          return `<span class="font-weight-bolder">${data.name}</span>`;
        }
      },
      {
        field: 'slug',
        title: 'Slug Perusahaan',
        template: function(data) {
          return `<span class="font-weight-bolder">${data.slug}</span>`;
        }
      },
      {
        field: 'email',
        title: 'Email',
        template: function(data) {
          return `<span class="font-weight-bolder">${data.email}</span>`;
        }
      },
      {
        field: 'Actions',
        title: 'Actions',
        sortable: false,
        width: 150,
        overflow: 'visible',
        autoHide: false,
        template: function(data) {
          return `
            <a href="${data.edit_partial_path}" class="btn btn-sm btn-clean btn-icon">
              <i class="la la-pencil text-warning"></i>
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
