
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/taglib.jsp" %>
<c:url var="userAPI" value="/api/user"/>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Building Management System - Add New Building</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <link
          rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
  />
  <style>
    /* Custom styles for combobox */
    .combobox {
      position: relative;
      display: inline-block;
      width: 100%;
    }
    .combobox select {
      appearance: none;
      -webkit-appearance: none;
      -moz-appearance: none;
      background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
      background-repeat: no-repeat;
      background-position: right 0.75rem center;
      background-size: 1em;
    }
    /* Custom checkbox style */
    .custom-checkbox input[type="checkbox"] {
      position: absolute;
      opacity: 0;
    }
    .custom-checkbox .checkmark {
      position: relative;
      display: inline-block;
      width: 1.25rem;
      height: 1.25rem;
      background-color: #fff;
      border: 1px solid #d1d5db;
      border-radius: 0.25rem;
      margin-right: 0.5rem;
    }
    .custom-checkbox input[type="checkbox"]:checked + .checkmark {
      background-color: #3b82f6;
      border-color: #3b82f6;
    }
    .custom-checkbox .checkmark:after {
      content: "";
      position: absolute;
      display: none;
      left: 7px;
      top: 3px;
      width: 5px;
      height: 10px;
      border: solid white;
      border-width: 0 2px 2px 0;
      transform: rotate(45deg);
    }
    .custom-checkbox input[type="checkbox"]:checked + .checkmark:after {
      display: block;
    }
    .table-container {
      box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1),
      0 2px 4px -1px rgba(0, 0, 0, 0.06);
    }
    .table-header {
      background-color: #3b82f6;
      color: white;
    }
    .table-row:hover {
      background-color: #f8fafc;
    }
    .action-btn {
      transition: all 0.2s ease-in-out;
    }
    .action-btn:hover {
      transform: scale(1.05);
    }
  </style>
</head>
<body class="bg-gray-100">
<div class="container mx-auto px-4 py-8 max-w-6xl">
  <div class="bg-white rounded-lg shadow-md overflow-hidden">
    <!-- Header -->
    <div class="bg-blue-600 px-6 py-4 flex items-center justify-between">
      <c:if test="${not empty userEdit.id}">
        <h1 class="text-2xl font-bold text-white">
          <i class="fas fa-building mr-2"></i> Cập nhật thông tin tài khoản
        </h1>
      </c:if>
      <c:if test="${empty userEdit.id}">
        <h1 class="text-2xl font-bold text-white">
          <i class="fas fa-building mr-2"></i> Thêm mới tài khoản
        </h1>
      </c:if>
      <button class="text-white hover:text-blue-200">
        <i class="fas fa-question-circle text-xl"></i>
      </button>
    </div>

    <!-- Form -->
    <form:form class="p-6" modelAttribute="userEdit" id="listForm" method="POST">
      <!-- Basic Information -->
      <div class="mb-8">
        <h2 class="text-xl font-semibold text-gray-800 border-b pb-2 mb-4">
          <i class="fas fa-info-circle text-blue-500 mr-2"></i> Thông tin cơ
          bản
        </h2>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          <form:hidden path="id" id="userId"></form:hidden>

          <div class="col-span-full">
            <label
                    class="block text-sm font-medium text-gray-700 mb-1"
            >Vai trò</label
            >
            <form:select path="roleCode" class="w-full border px-3 py-2 rounded-md">
              <form:option value="" label="-- Chọn vai trò --" />
              <form:options items="${userEdit.roles}" itemValue="code" itemLabel="name"/>
            </form:select>
          </div>

          <div>
            <label
                    class="block text-sm font-medium text-gray-700 mb-1"
            >Tên đăng nhập</label
            >
            <c:if test="${not empty userEdit.id}">
              <form:input
                      type="text"
                      path="userName"
                      class="w-full px-3 py-2 border rounded-md shadow-sm"
                      readonly="true"
              />
            </c:if>
            <c:if test="${empty userEdit.id}">
              <form:input
                      type="text"
                      path="userName"
                      class="w-full px-3 py-2 border rounded-md shadow-sm"
              />
            </c:if>
          </div>

          <div>
            <label
                    class="block text-sm font-medium text-gray-700 mb-1"
            >Họ tên</label
            >
            <form:input
                    type="text"
                    path="fullName"
                    class="w-full px-3 py-2 border rounded-md shadow-sm"
            />
          </div>
          <div>
            <label
                    class="block text-sm font-medium text-gray-700 mb-1"
            >SĐT</label
            >
            <form:input
                    type="number"
                    path="phone"
                    class="w-full px-3 py-2 border rounded-md shadow-sm"
            />
          </div>
          <div>
            <label
                    class="block text-sm font-medium text-gray-700 mb-1"
            >Email</label
            >
            <form:input
                    type="email"
                    path="email"
                    class="w-full px-3 py-2 border rounded-md shadow-sm"
            />
          </div>
        </div>
      </div>

      <!-- Form Actions -->
      <div class="flex justify-end gap-3 pt-4 border-t">
        <button
                id="btnCancel"
                type="button"
                class="px-4 py-2 border rounded-md text-gray-700 bg-white hover:bg-gray-50"
        >
          <i class="fas fa-times mr-2"></i> Hủy
        </button>
        <button
                id="btnInsertOrUpdateUser"
                type="button"
                class="px-4 py-2 text-white bg-blue-600 rounded-md hover:bg-blue-700"
        >
          <i class="fas fa-save mr-2"></i> Lưu
        </button>
        <c:if test="${not empty userEdit.id}">
          <button
                  id="btnResetPass"
                  type="button"
                  class="px-5 py-2 bg-blue-600 text-white font-semibold rounded-lg shadow-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-400 focus:ring-opacity-75 transition duration-200">
            🔒 Reset Password
          </button>
        </c:if>
      </div>
    </form:form>
  </div>

</div>


<script>

  $("#btnInsertOrUpdateUser").click(function () {
    var data = {};
    var formData = $("#listForm").serializeArray();

    $.each(formData, function (i, v) {
      data["" + v.name + ""] = v.value;

    });
    if (!data.userName || !data.fullName || !data.roleCode ) {
      alert("Vui lòng điền đầy đủ thông tin");
      return;
    }

    addOrUpdateUser(data);
  });

  function addOrUpdateUser(data){
    $.ajax({
      type: "POST",
      url: "/api/user",
      data: JSON.stringify(data),
      contentType: "application/json", // đinh dạng dữ liệu từ phía client gửi về
      dataType: "JSON", // định dạng dữ liệu từ server gửi lên
      success: function (respond) {
        console.log("ok rồi nhé anh ba");
        window.location.href = "/admin/user-list";
      },
      error: function (response) {
        console.log("lỗi rồi anh ba");
        console.log(response);
      }
    });
  }

  $('#btnCancel').click(function (){
    window.location.href = "/admin/user-list";
  });

  $('#btnResetPass').click(function (event) {
    event.preventDefault();
    resetPassword($('#userId').val());
  });

  function resetPassword(id) {
    $.ajax({
      url: '${userAPI}/password/'+id+'/reset',
      type: 'PUT',
      dataType: 'json',
      success: function (res) {
        alert("✅ Reset mật khẩu thành công cho user ID: " + res.id);
      },
      error: function (res) {
        alert("❌ Có lỗi xảy ra, vui lòng thử lại!");
      }
    });
  }

</script>
</body>
</html>
