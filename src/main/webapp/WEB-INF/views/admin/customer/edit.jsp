
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/taglib.jsp" %>
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
            <c:if test="${not empty customerEdit.id}">
                <h1 class="text-2xl font-bold text-white">
                    <i class="fas fa-building mr-2"></i> Cập nhật thông tin khách hàng
                </h1>
            </c:if>
            <c:if test="${empty customerEdit.id}">
                <h1 class="text-2xl font-bold text-white">
                    <i class="fas fa-building mr-2"></i> Thêm mới khách hàng
                </h1>
            </c:if>
            <button class="text-white hover:text-blue-200">
                <i class="fas fa-question-circle text-xl"></i>
            </button>
        </div>

        <!-- Form -->
        <form:form class="p-6" modelAttribute="customerEdit" id="listForm" method="GET">
            <!-- Basic Information -->
            <div class="mb-8">
                <h2 class="text-xl font-semibold text-gray-800 border-b pb-2 mb-4">
                    <i class="fas fa-info-circle text-blue-500 mr-2"></i> Thông tin cơ
                    bản
                </h2>

                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    <form:hidden path="id" id="customerId"></form:hidden>
                    <div>
                        <label
                                class="block text-sm font-medium text-gray-700 mb-1"
                        >Tên khách hàng *</label
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
                                type="text"
                                path="email"
                                class="w-full px-3 py-2 border rounded-md shadow-sm"
                        />
                    </div>

                    <div>
                        <label
                                class="block text-sm font-medium text-gray-700 mb-1"
                        >Tên công ty</label
                        >
                        <form:input
                                type="text"
                                path="companyName"
                                class="w-full px-3 py-2 border rounded-md shadow-sm"
                        />
                    </div>

                    <div>
                        <label
                                class="block text-sm font-medium text-gray-700 mb-1"
                        >Nhu cầu</label
                        >
                        <form:input
                                type="text"
                                path="demand"
                                class="w-full px-3 py-2 border rounded-md shadow-sm"
                        />
                    </div>

                    <div class="col-span-full">
                        <label
                                class="block text-sm font-medium text-gray-700 mb-1"
                        >Tình trạng</label
                        >
                        <form:select path="status" class="w-full border px-3 py-2 rounded-md">
                            <form:option value="" label="-- Chọn tình trạng --" />
                            <form:option value="CHUA_XU_LY" label="Chưa xử lý" />
                            <form:option value="DANG_XU_LY" label="Đang xử lý" />
                            <form:option value="DA_XU_LY" label="Đã xử lý" />
                        </form:select>
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
                        id="btnInsertOrUpdateCustomer"
                        type="button"
                        class="px-4 py-2 text-white bg-blue-600 rounded-md hover:bg-blue-700"
                >
                    <i class="fas fa-save mr-2"></i> Lưu
                </button>
            </div>
        </form:form>
    </div>

    <c:forEach var="item" items="${transactionType}">
        <div class="bg-gray-50 p-4 md:p-8">
            <div class="container mx-auto">
                <div
                        class="flex flex-col md:flex-row justify-between items-start md:items-center mb-6 gap-4"
                >
                    <h2 class="text-2xl font-bold text-blue-600">
                            ${item.value}
                    </h2>
                    <button
                            class="flex items-center gap-2 bg-blue-600 hover:bg-blue-700 text-white font-medium py-2 px-4 rounded-lg transition-all duration-200 shadow-md hover:shadow-lg"
                            onclick="transactionType('${item.key}', ${customerEdit.id})"
                    >
                        <i class="fas fa-location-arrow text-yellow-400 text-lg"></i>
                        <span>Add Transaction</span>
                    </button>
                </div>

                <c:if test="${item.key == 'CALL'}">
                    <div class="mt-10">
                        <hr class="mb-6 border-t-2 border-gray-200"/>
                        <div class="bg-white rounded-lg overflow-hidden table-container">
                            <div class="overflow-x-auto">
                                <table class="min-w-full divide-y divide-gray-200">
                                    <thead class="table-header">
                                    <tr>
                                        <th
                                                class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider"
                                        >
                                            Ngày tạo
                                        </th>
                                        <th
                                                class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider"
                                        >
                                            Người tạo
                                        </th>
                                        <th
                                                class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider"
                                        >
                                            Ngày sửa
                                        </th>
                                        <th
                                                class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider"
                                        >
                                            Người sửa
                                        </th>
                                        <th
                                                class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider"
                                        >
                                            Chi tiết giao dịch
                                        </th>
                                        <th
                                                class="px-6 py-3 text-right text-xs font-medium uppercase tracking-wider"
                                        >
                                            Thao tác
                                        </th>
                                    </tr>
                                    </thead>
                                    <tbody class="bg-white divide-y divide-gray-200">
                                    <c:forEach var="transaction" items="${listCall}">
                                        <tr class="table-row">
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">
                                                    ${transaction.createdDate}
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">
                                                    ${transaction.createdBy}
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">
                                                    ${transaction.modifiedDate}
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">
                                                    ${transaction.modifiedBy}
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">
                                                    ${transaction.transactionDetail}
                                            </td>
                                            <td
                                                    class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium"
                                            >
                                                <button
                                                        class="action-btn bg-blue-100 hover:bg-blue-200 text-blue-800 p-2 rounded-full"
                                                        data-toggle="tooltip"
                                                        title="Sửa thông tin giao dịch"
                                                        onclick="UpdateTransaction(${transaction.id}, '${item.key}', '${transaction.transactionDetail}'
                                                                ,'${transaction.buildingId}','${transaction.amount}','${transaction.startDate}'
                                                                ,'${transaction.endDate}' ,'${transaction.nameOfBuilding}' )"
                                                >
                                                    <i class="fas fa-pencil-alt"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </c:if>

                <c:if test="${item.key == 'VIEWING'}">
                    <div class="mt-10">
                        <hr class="mb-6 border-t-2 border-gray-200"/>
                        <div class="bg-white rounded-lg overflow-hidden table-container">
                            <div class="overflow-x-auto">
                                <table class="min-w-full divide-y divide-gray-200">
                                    <thead class="table-header">
                                    <tr>
                                        <th
                                                class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider"
                                        >
                                            Ngày tạo
                                        </th>
                                        <th
                                                class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider"
                                        >
                                            Người tạo
                                        </th>
                                        <th
                                                class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider"
                                        >
                                            Ngày sửa
                                        </th>
                                        <th
                                                class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider"
                                        >
                                            Người sửa
                                        </th>
                                        <th
                                                class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider"
                                        >
                                            Tòa nhà
                                        </th>
                                        <th
                                                class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider"
                                        >
                                            Chi tiết giao dịch
                                        </th>
                                        <th
                                                class="px-6 py-3 text-right text-xs font-medium uppercase tracking-wider"
                                        >
                                            Thao tác
                                        </th>
                                    </tr>
                                    </thead>
                                    <tbody class="bg-white divide-y divide-gray-200">
                                    <c:forEach var="transaction" items="${listViewing}">
                                        <tr class="table-row">
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">
                                                    ${transaction.createdDate}
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">
                                                    ${transaction.createdBy}
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">
                                                    ${transaction.modifiedDate}
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">
                                                    ${transaction.modifiedBy}
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">
                                                    ${transaction.nameOfBuilding}
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">
                                                    ${transaction.transactionDetail}
                                            </td>
                                            <td
                                                    class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium"
                                            >
                                                <button
                                                        class="action-btn bg-blue-100 hover:bg-blue-200 text-blue-800 p-2 rounded-full"
                                                        data-toggle="tooltip"
                                                        title="Sửa thông tin giao dịch"
                                                        onclick="UpdateTransaction(${transaction.id}, '${item.key}', '${transaction.transactionDetail}'
                                                                ,'${transaction.buildingId}','${transaction.amount}','${transaction.startDate}'
                                                                ,'${transaction.endDate}' ,'${transaction.nameOfBuilding}' )"
                                                >
                                                    <i class="fas fa-pencil-alt"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </c:if>

                <c:if test="${item.key == 'DEPOSIT'}">
                    <div class="mt-10">
                        <hr class="mb-6 border-t-2 border-gray-200"/>
                        <div class="bg-white rounded-lg overflow-hidden table-container">
                            <div class="overflow-x-auto">
                                <table class="min-w-full divide-y divide-gray-200">
                                    <thead class="table-header">
                                    <tr>
                                        <th
                                                class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider"
                                        >
                                            Ngày tạo
                                        </th>
                                        <th
                                                class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider"
                                        >
                                            Người tạo
                                        </th>
                                        <th
                                                class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider"
                                        >
                                            Ngày sửa
                                        </th>
                                        <th
                                                class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider"
                                        >
                                            Người sửa
                                        </th>
                                        <th
                                                class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider"
                                        >
                                            Tòa nhà
                                        </th>
                                        <th
                                                class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider"
                                        >
                                            Khoản đặt cọc
                                        </th>
                                        <th
                                                class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider"
                                        >
                                            Thời gian
                                        </th>
                                        <th
                                                class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider"
                                        >
                                            Chi tiết giao dịch
                                        </th>
                                        <th
                                                class="px-6 py-3 text-right text-xs font-medium uppercase tracking-wider"
                                        >
                                            Thao tác
                                        </th>
                                    </tr>
                                    </thead>
                                    <tbody class="bg-white divide-y divide-gray-200">
                                    <c:forEach var="transaction" items="${listDeposit}">
                                        <tr class="table-row">
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">
                                                    ${transaction.createdDate}
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">
                                                    ${transaction.createdBy}
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">
                                                    ${transaction.modifiedDate}
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">
                                                    ${transaction.modifiedBy}
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">
                                                    ${transaction.nameOfBuilding}
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">
                                                    ${transaction.amount}
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">
                                                    ${transaction.startDate}
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">
                                                    ${transaction.transactionDetail}
                                            </td>
                                            <td
                                                    class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium"
                                            >
                                                <button
                                                        class="action-btn bg-blue-100 hover:bg-blue-200 text-blue-800 p-2 rounded-full"
                                                        data-toggle="tooltip"
                                                        title="Sửa thông tin giao dịch"
                                                        onclick="UpdateTransaction(${transaction.id}, '${item.key}', '${transaction.transactionDetail}'
                                                                ,'${transaction.buildingId}','${transaction.amount}','${transaction.startDate}'
                                                                ,'${transaction.endDate}' ,'${transaction.nameOfBuilding}' )"
                                                >
                                                    <i class="fas fa-pencil-alt"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </c:if>

                <c:if test="${item.key == 'RENTED'}">
                    <div class="mt-10">
                        <hr class="mb-6 border-t-2 border-gray-200"/>
                        <div class="bg-white rounded-lg overflow-hidden table-container">
                            <div class="overflow-x-auto">
                                <table class="min-w-full divide-y divide-gray-200">
                                    <thead class="table-header">
                                    <tr>
                                        <th
                                                class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider"
                                        >
                                            Ngày tạo
                                        </th>
                                        <th
                                                class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider"
                                        >
                                            Người tạo
                                        </th>
                                        <th
                                                class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider"
                                        >
                                            Ngày sửa
                                        </th>
                                        <th
                                                class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider"
                                        >
                                            Người sửa
                                        </th>
                                        <th
                                                class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider"
                                        >
                                            Tòa nhà
                                        </th>
                                        <th
                                                class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider"
                                        >
                                            Tiền thuê/tháng
                                        </th>
                                        <th
                                                class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider"
                                        >
                                            Ngày bắt đầu
                                        </th>
                                        <th
                                                class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider"
                                        >
                                            Ngày kết thúc
                                        </th>
                                        <th
                                                class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider"
                                        >
                                            Chi tiết giao dịch
                                        </th>
                                        <th
                                                class="px-6 py-3 text-right text-xs font-medium uppercase tracking-wider"
                                        >
                                            Thao tác
                                        </th>
                                    </tr>
                                    </thead>
                                    <tbody class="bg-white divide-y divide-gray-200">
                                    <c:forEach var="transaction" items="${listRent}">
                                        <tr class="table-row">
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">
                                                    ${transaction.createdDate}
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">
                                                    ${transaction.createdBy}
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">
                                                    ${transaction.modifiedDate}
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">
                                                    ${transaction.modifiedBy}
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">
                                                    ${transaction.nameOfBuilding}
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">
                                                    ${transaction.amount}
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">
                                                    ${transaction.startDate}
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">
                                                    ${transaction.endDate}
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">
                                                    ${transaction.transactionDetail}
                                            </td>
                                            <td
                                                    class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium"
                                            >
                                                <button
                                                        class="action-btn bg-blue-100 hover:bg-blue-200 text-blue-800 p-2 rounded-full"
                                                        data-toggle="tooltip"
                                                        title="Sửa thông tin giao dịch"
                                                        onclick="UpdateTransaction(${transaction.id}, '${item.key}', '${transaction.transactionDetail}'
                                                                ,'${transaction.buildingId}','${transaction.amount}','${transaction.startDate}'
                                                                ,'${transaction.endDate}' ,'${transaction.nameOfBuilding}' )"
                                                >
                                                    <i class="fas fa-pencil-alt"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </c:forEach>
</div>

<%--Modal cho phần giao dịch--%>
<div
        id="modalContainer"
        class="fixed inset-0 z-50 flex items-center justify-center p-4 hidden"
>
    <div
            class="bg-white rounded-2xl shadow-2xl w-full max-w-md overflow-hidden fade-in"
    >
        <!-- Modal Header -->
        <div class="bg-gradient-to-r from-primary to-secondary p-5">
            <div class="flex justify-between items-center">
                <h2 class="modal-title text-2xl font-bold text-white">Nhập giao dịch</h2>
                <button
                        id="closeModal"
                        class="text-white hover:text-gray-200 focus:outline-none"
                        onclick="closeModal()"
                >
                    <i class="fas fa-times text-2xl"></i>
                </button>
            </div>
            <p class="text-blue-100 mt-1">
                Please fill in the required information
            </p>
        </div>

        <!-- Modal Body -->
        <div class="p-6">
            <form id="modalForm">
                <div id="field-building" class="mb-6">
                    <label  class="block text-gray-700 font-medium mb-2"
                    >Chọn tòa nhà</label
                    >
                    <div class="relative">
                        <select
                                id="nameOfBuilding"
                                class="custom-select w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:border-primary appearance-none transition duration-200"
                                required
                        >
                            <option value="">-- Chọn tòa nhà --</option>

                            <c:forEach var="b" items="${availableBuildings}">
                                <option class="building-option available" value="${b.id}">${b.name}</option>
                            </c:forEach>

                            <c:forEach var="b" items="${depositedBuildings}">
                                <option class="building-option deposited" value="${b.id}">${b.name}</option>
                            </c:forEach>
                        </select>
                        <input type="text" id="buildingNameDisplay" class="form-input w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:border-primary transition duration-200"
                               readonly style="display:none;"/>

                        <input type="hidden" id="buildingIdHidden" name="buildingId">
                        <div
                                class="absolute inset-y-0 right-0 flex items-center px-2 pointer-events-none"
                        >
                            <i class="fas fa-chevron-down text-gray-400"></i>
                        </div>
                    </div>
                </div>

                <div id="field-amount" class="mb-5">
                    <label
                            id ="money"
                            class="block text-gray-700 font-medium mb-2"
                    >Tiền thuê/tháng</label
                    >
                    <div class="relative">
                        <input
                                type="number" id="amount"
                                class="form-input w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:border-primary transition duration-200"
                                required
                        />
                        <div class="absolute inset-y-0 right-0 flex items-center pr-3">
                            <i class="fas fa-user text-gray-400"></i>
                        </div>
                    </div>
                </div>

                <div id="field-startDate" class="mb-5">
                    <label
                            class="block text-gray-700 font-medium mb-2"
                    >Ngày bắt đầu</label
                    >
                    <div class="relative">
                        <input
                                type="date"
                                id="startDate"
                                class="form-input w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:border-primary transition duration-200"
                                required
                        />
                    </div>
                </div>

                <div id="field-endDate" class="mb-5">
                    <label for="endDate" class="block text-gray-700 font-medium mb-2"
                    >Ngày kết thúc</label
                    >
                    <div class="relative">
                        <input
                                type="date"
                                id="endDate"
                                class="form-input w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:border-primary transition duration-200"
                                required
                        />
                        <div class="absolute right-3 date-icon text-gray-400">
                            <i class="far fa-calendar-check"></i>
                        </div>
                    </div>
                </div>

                <div id="field-detail" class="mb-5">
                    <label class="block text-gray-700 font-medium mb-2"
                    >Nội dung</label
                    >
                    <div class="relative">
                        <input
                                type="text"
                                id="transactionDetail"
                                class="form-input w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:border-primary transition duration-200"
                                required
                        />
                        <div class="absolute inset-y-0 right-0 flex items-center pr-3">
                            <i class="fas fa-user-tag text-gray-400"></i>
                        </div>
                    </div>
                </div>

                <!-- Form Actions -->
                <div class="flex justify-between gap-3 mt-2">
                    <button
                            type="reset"
                            id="resetForm"
                            class="flex-1 bg-gray-200 hover:bg-gray-300 text-gray-800 font-bold py-3 px-4 rounded-lg transition duration-200"
                    >
                        <i class="fas fa-redo mr-2"></i> Reset
                    </button>
                    <button
                            type="button"
                            class="flex-1 bg-primary hover:bg-blue-700 text-white font-bold py-3 px-4 rounded-lg shadow-md transition duration-200"
                            id="btnAddOrUpdateTransaction"
                    >
                        <i class="fas fa-paper-plane mr-2"></i> Lưu
                    </button>
                </div>
                <input type="hidden" name="customerId" id="customerId" value="">
                <input type="hidden" name="code" id="code" value="">
                <input type="hidden" name="id" id="id" value="">
            </form>
        </div>

        <!-- Modal Footer -->
        <div class="bg-gray-50 px-6 py-4 text-center">
            <p class="text-gray-500 text-sm">All fields are required</p>
        </div>
    </div>
</div>

<script>


    $("#btnInsertOrUpdateCustomer").click(function () {
        var data = {};
        var formData = $("#listForm").serializeArray();

        $.each(formData, function (i, v) {
            data["" + v.name + ""] = v.value;

        });
        if (!data.fullName || !data.phone || !data.status ) {
            alert("Vui lòng điền đầy đủ thông tin bắt buộc (tên khách hàng, số điện thoại, tình trạng).");
            return;
        }

        addOrUpdateCustomer(data);
    });

    function addOrUpdateCustomer(data){
        $.ajax({
            type: "POST",
            url: "/api/customer",
            data: JSON.stringify(data),
            contentType: "application/json", // đinh dạng dữ liệu từ phía client gửi về
            dataType: "JSON", // định dạng dữ liệu từ server gửi lên
            success: function (respond) {
                console.log("ok rồi nhé anh ba");
                window.location.href = "/admin/customer-list";
            },
            error: function (response) {
                console.log("lỗi rồi anh ba");
                console.log(response);
            }
        });
    }

    $('#btnCancel').click(function (){
        window.location.href = "/admin/customer-list";
    });

    function closeModal() {

        document.getElementById("modalContainer").classList.add("hidden");
        $('#id').val('');
        $('#customerId').val('');
        $('#code').val('');
        $('#transactionDetail').val('');
        $('#nameOfBuilding').val('');
        $('#buildingIdHidden').val('');
        $('#amount').val('');
        $('#startDate').val('');
        $('#endDate').val('');

        $('#buildingNameDisplay').val('').hide();
        $('#nameOfBuilding').show();
        $('#money').text("Tiền thuê/tháng");

        document.getElementById("nameOfBuilding").disabled = false;
        document.getElementById("amount").readOnly = false;
        document.getElementById("startDate").readOnly = false;
        document.getElementById("endDate").readOnly = false;
        document.getElementById("transactionDetail").disabled = false;

        ["field-building", "field-amount", "field-startDate", "field-endDate"]
            .forEach(id => document.getElementById(id).classList.add("hidden"));

    }

    function transactionType(code, customerId) {
        // mở modal
        document.getElementById("modalContainer").classList.remove("hidden");

        document.querySelectorAll("#nameOfBuilding .building-option")
            .forEach(opt => opt.hidden = true);


        // ẩn hết các field trước
        ["field-building", "field-amount", "field-startDate", "field-endDate"]
            .forEach(id => document.getElementById(id).classList.add("hidden"));

        // bật theo type
        if (code === "CALL") {
            // chỉ hiện detail (mặc định luôn visible)
        }
        else if (code === "VIEWING") {
            document.getElementById("field-building").classList.remove("hidden");
            document.querySelectorAll("#nameOfBuilding .available")
                .forEach(opt => opt.hidden = false);
        }
        else if (code === "DEPOSIT") {
            document.getElementById("field-building").classList.remove("hidden");
            document.getElementById("field-amount").classList.remove("hidden");
            document.getElementById("field-startDate").classList.remove("hidden");

            document.querySelectorAll("#nameOfBuilding .available")
                .forEach(opt => opt.hidden = false);

            $('#money').text("Khoản cọc");
        }
        else if (code === "RENTED") {
            document.getElementById("field-building").classList.remove("hidden");
            document.getElementById("field-amount").classList.remove("hidden");
            document.getElementById("field-startDate").classList.remove("hidden");
            document.getElementById("field-endDate").classList.remove("hidden");

            document.querySelectorAll("#nameOfBuilding .deposited")
                .forEach(opt => opt.hidden = false);

            $('#money').text("Tiền thuê/tháng");
        }

        const select = document.getElementById("nameOfBuilding");
        if (select.selectedOptions.length && select.selectedOptions[0].hidden) {
            select.value = "";
        }

        $('#customerId').val(customerId);
        $('#code').val(code);

        $('.modal-title').text("Thêm giao dịch");
        $('#btnAddOrUpdateTransaction').text("Thêm giao dịch");
    }

    function UpdateTransaction(id, code, transactionDetail, buildingId, amount, startDate, endDate,nameOfBuilding) {
        // mở modal
        document.getElementById("modalContainer").classList.remove("hidden");

        ["field-building", "field-amount", "field-startDate", "field-endDate"]
            .forEach(id => document.getElementById(id).classList.add("hidden"));

        if (code === "CALL") {
            // chỉ detail (mặc định luôn hiện)
        }
        else if (code === "VIEWING") {
            document.getElementById("field-building").classList.remove("hidden");

        }
        else if (code === "DEPOSIT") {
            document.getElementById("field-building").classList.remove("hidden");
            document.getElementById("field-amount").classList.remove("hidden");
            document.getElementById("field-startDate").classList.remove("hidden");
            $('#money').text("Khoản cọc");
        }
        else if (code === "RENTED") {
            document.getElementById("field-building").classList.remove("hidden");
            document.getElementById("field-amount").classList.remove("hidden");
            document.getElementById("field-startDate").classList.remove("hidden");
            document.getElementById("field-endDate").classList.remove("hidden");
            $('#money').text("Tiền thuê/tháng");
        }

        // Disable các field không được sửa
        document.getElementById("nameOfBuilding").disabled = true;
        document.getElementById("amount").readOnly = true;
        document.getElementById("startDate").readOnly = true;
        document.getElementById("endDate").readOnly = true;

        document.getElementById("transactionDetail").disabled = false;

        $('#id').val(id);
        $('#code').val(code);
        $('#transactionDetail').val(transactionDetail);
        $('#nameOfBuilding').val(buildingId);
        $('#amount').val(amount);
        if (startDate) {
            $('#startDate').val(formatDate(startDate));
        }
        if (endDate) {
            $('#endDate').val(formatDate(endDate));
        }
        if (code === "VIEWING" || code === "DEPOSIT" || code === "RENTED") {
            $('#nameOfBuilding').hide();
            $('#buildingNameDisplay').val(nameOfBuilding).show();
        } else {
            $('#nameOfBuilding').show();
            $('#buildingNameDisplay').hide();
        }

        $('#buildingIdHidden').val(buildingId);

        $('.modal-title').text("Sửa giao dịch");
        $('#btnAddOrUpdateTransaction').text("Cập nhật giao dịch");
    }

    function formatDate(dateTimeStr) {
        // nếu là "2025-08-19 00:00:00" -> lấy phần "2025-08-19"
        return dateTimeStr.split(" ")[0];
    }

    $('#btnAddOrUpdateTransaction').click(function (e) {
        e.preventDefault();
        var data = {};
        data['id'] = $('#id').val();
        data['customerId'] = $('#customerId').val();
        data['transactionType'] = $('#code').val();
        data['transactionDetail'] = $('#transactionDetail').val();
        data['buildingId'] = $('#nameOfBuilding').val();
        data['amount'] = $('#amount').val();
        data['startDate'] = $('#startDate').val();
        data['endDate'] = $('#endDate').val();

        addTransaction(data);
    });


    function addTransaction(data){
        $.ajax({
            type: "POST",
            url: "/api/customer/transaction",
            data: JSON.stringify(data),
            contentType: "application/json", // đinh dạng dữ liệu từ phía client gửi về
            success: function (respond) {
                if (!data.id) {
                    alert("Thêm giao dịch thành công");
                } else {
                    alert("Cập nhật giao dịch thành công");
                }
                window.location.href = "/admin/customer-edit-" + data.customerId;

            },
            error: function (response) {
                alert("Có lỗi xảy ra khi lưu giao dịch.");
                console.log(response);
            }
        });
    }

</script>
</body>
</html>
