<%--
  Created by IntelliJ IDEA.
  User: LENOVO
  Date: 8/28/2025
  Time: 12:11 AM
  To change this template use File | Settings | File Templates.
--%>
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
<div class="bg-white rounded-lg shadow-md overflow-hidden mt-8">
  <!-- Header -->
  <div class="bg-blue-600 px-6 py-4 flex items-center justify-between">
    <h1 class="text-2xl font-bold text-white">
      <i class="fas fa-key mr-2"></i> Đổi mật khẩu
    </h1>
  </div>

  <!-- Body -->
  <form id="changePasswordForm" class="p-6">
    <input type="hidden" id="userId" value="${userEdit.id}"/>
    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
      <!-- Mật khẩu hiện tại -->
      <div>
        <label class="block text-sm font-medium text-gray-700 mb-1">Mật khẩu hiện tại</label>
        <input type="password" id="currentPassword" name="currentPassword"
               class="w-full px-3 py-2 border rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500"/>
      </div>

      <!-- Mật khẩu mới -->
      <div>
        <label class="block text-sm font-medium text-gray-700 mb-1">Mật khẩu mới</label>
        <input type="password" id="newPassword" name="newPassword"
               class="w-full px-3 py-2 border rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500"/>
      </div>

      <!-- Xác nhận mật khẩu mới -->
      <div>
        <label class="block text-sm font-medium text-gray-700 mb-1">Nhập lại mật khẩu mới</label>
        <input type="password" id="confirmPassword" name="confirmPassword"
               class="w-full px-3 py-2 border rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500"/>
      </div>
    </div>

    <!-- Actions -->
    <div class="flex justify-end gap-3 pt-6 border-t mt-6">
      <button type="button" id="btnCancelChangePass"
              class="px-4 py-2 border rounded-md text-gray-700 bg-white hover:bg-gray-50">
        <i class="fas fa-times mr-2"></i> Hủy
      </button>
      <button type="button" id="btnChangePassword"
              class="px-4 py-2 text-white bg-blue-600 rounded-md hover:bg-blue-700">
        <i class="fas fa-save mr-2"></i> Đổi mật khẩu
      </button>
    </div>
  </form>
</div>

<script>
  $('#btnChangePassword').click(function () {
    let data = {
      id: $('#userId').val(),
      currentPassword: $('#currentPassword').val(),
      newPassword: $('#newPassword').val(),
      confirmPassword: $('#confirmPassword').val()
    };

    if (!data.currentPassword || !data.newPassword || !data.confirmPassword) {
      alert("⚠️ Vui lòng điền đầy đủ thông tin!");
      return;
    }
    if (data.newPassword !== data.confirmPassword) {
      alert("⚠️ Mật khẩu mới không khớp!");
      return;
    }

    $.ajax({
      url: "${userAPI}/change-password/" + data.id,
      type: 'PUT',
      data: JSON.stringify(data),
      contentType: 'application/json',
      success: function (res) {
        alert("✅ " + res);
        $('#changePasswordForm')[0].reset();
      },
      error: function (res) {
        alert("❌ " + res.responseText);
      }
    });
  });

  $('#btnCancelChangePass').click(function () {
    $('#changePasswordForm')[0].reset();
  });

</script>
</body>
</html>

