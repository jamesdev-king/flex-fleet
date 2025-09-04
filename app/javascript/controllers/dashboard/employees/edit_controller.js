import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="dashboard--employees--edit"
export default class extends Controller {
  static targets = ["roles"];
  connect() {}

  addRole({ params: { companyId, companyName, roleOptions } }) {
    const fieldPrefix = `employee[company_employees_attributes][${this.rolesTarget.children.length}]`;
    const row = document.createElement("tr");
    const companyIdField = document.createElement("input");
    companyIdField.name = `${fieldPrefix}[company_id]`;
    companyIdField.id = `${fieldPrefix}[company_id]`.replace(/\[\]/g, "_");
    companyIdField.value = companyId;
    companyIdField.type = "hidden";

    row.appendChild(companyIdField);

    const companyNameColumn = document.createElement("td");
    companyNameColumn.className =
      "whitespace-nowrap py-4 pl-4 pr-3 text-sm font-medium text-gray-900 sm:pl-6";

    companyNameColumn.innerHTML = companyName;
    row.appendChild(companyNameColumn);

    const rolesSelect = document.createElement("select");
    rolesSelect.name = `${fieldPrefix}[role]`;
    rolesSelect.id = `${fieldPrefix}[role]`.replace(/\[\]/g, "_");
    rolesSelect.innerHTML = roleOptions;
    const roleColumn = document.createElement("td");
    roleColumn.className = "whitespace-nowrap px-3 py-4 text-sm text-gray-500";
    roleColumn.appendChild(rolesSelect);

    row.appendChild(roleColumn);

    const removeColumn = document.createElement("td");
    removeColumn.className =
      "relative whitespace-nowrap py-4 pl-3 pr-4 text-right text-sm font-medium sm:pr-6";
    row.appendChild(removeColumn);
    this.rolesTarget.appendChild(row);
  }

  removeRole({ target }) {
    const grandparent = target.parentElement.parentElement;
    const destroyField = grandparent.querySelector(
      'input[type="hidden"].destroy',
    );
    destroyField.value = true;
    grandparent.classList.add("disabled");
  }
}
