
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
    </style>
</head>
<body class="bg-gray-100">
<div class="container mx-auto px-4 py-8 max-w-6xl">
    <div class="bg-white rounded-lg shadow-md overflow-hidden">
        <!-- Header -->
        <div class="bg-blue-600 px-6 py-4 flex items-center justify-between">
            <c:if test="${not empty buildingEdit.id}">
                <h1 class="text-2xl font-bold text-white">
                    <i class="fas fa-building mr-2"></i> Cập nhật tòa nhà
                </h1>
            </c:if>
            <c:if test="${empty buildingEdit.id}">
                <h1 class="text-2xl font-bold text-white">
                    <i class="fas fa-building mr-2"></i> Thêm mới tòa nhà
                </h1>
            </c:if>
            <button class="text-white hover:text-blue-200">
                <i class="fas fa-question-circle text-xl"></i>
            </button>
        </div>

        <!-- Form -->
        <form:form class="p-6" modelAttribute="buildingEdit" id="listForm" method="GET">
            <!-- Basic Information -->
            <div class="mb-8">
                <h2 class="text-xl font-semibold text-gray-800 border-b pb-2 mb-4">
                    <i class="fas fa-info-circle text-blue-500 mr-2"></i> Thông tin cơ
                    bản
                </h2>

                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    <form:hidden path="id" id="buildingID"></form:hidden>
                    <div>
                        <label
                                for="name"
                                class="block text-sm font-medium text-gray-700 mb-1"
                        >Tên tòa nhà *</label
                        >
                        <form:input
                                type="text"
                                path="name"
                                class="w-full px-3 py-2 border rounded-md shadow-sm"
                        />
                    </div>

                    <div>
                        <label
                                for="structure"
                                class="block text-sm font-medium text-gray-700 mb-1"
                        >Cấu trúc</label
                        >
                        <form:input
                                type="text"
                                path="structure"
                                class="w-full px-3 py-2 border rounded-md shadow-sm"
                        />
                    </div>

                    <div>
                        <label
                                class="block text-sm font-medium text-gray-700 mb-1"
                        >Số tầng hầm</label
                        >
                        <form:input
                                type="number"
                                path="numberOfBasement"
                                class="w-full px-3 py-2 border rounded-md shadow-sm"
                        />
                    </div>

                    <div>
                        <label
                                class="block text-sm font-medium text-gray-700 mb-1"
                        >Diện tích sàn (m²)</label
                        >
                        <form:input
                                type="number"
                                path="floorArea"
                                class="w-full px-3 py-2 border rounded-md shadow-sm"
                        />
                    </div>

                    <div>
                        <label
                                class="block text-sm font-medium text-gray-700 mb-1"
                        >Hướng</label
                        >
                        <form:input
                                type="text"
                                path="direction"
                                class="w-full px-3 py-2 border rounded-md shadow-sm"
                        />
                    </div>

                    <div>
                        <label
                                for="level"
                                class="block text-sm font-medium text-gray-700 mb-1"
                        >Hạng</label
                        >
                        <form:input
                                type="text"
                                path="level"
                                class="w-full px-3 py-2 border rounded-md shadow-sm"
                        />
                    </div>

                    <div>
                        <label
                                class="block text-sm font-medium text-gray-700 mb-1"
                        >Năm xây</label
                        >
                        <form:input
                                type="number"
                                path="yearBuilt"
                                class="w-full px-3 py-2 border rounded-md shadow-sm"
                        />
                    </div>

                    <div >
                        <label
                                class="block text-sm font-medium text-gray-700 mb-1"
                        >Diện tích thuê</label
                        >
                        <form:input
                                type="text"
                                path="rentArea"
                                class="w-full px-3 py-2 border rounded-md shadow-sm"
                        />
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">
                            Kiểu tòa nhà
                        </label>

                        <div class="flex space-x-4">
                            <div class="flex items-center">
                                <form:checkboxes
                                        path="typeCode"
                                        items="${buildingTypes}"
                                        class="mr-2"
                                />
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Location Info -->
            <div class="mb-8">
                <h2 class="text-xl font-semibold text-gray-800 border-b pb-2 mb-4">
                    <i class="fas fa-map-marker-alt text-blue-500 mr-2"></i> Thông tin
                    vị trí
                </h2>

                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    <div class="md:col-span-2 lg:col-span-3">
                        <label
                                class="block text-sm font-medium text-gray-700 mb-1"
                        >Số nhà</label
                        >
                        <form:input
                                type="text"
                                path="house_number"
                                class="w-full px-3 py-2 border rounded-md shadow-sm"
                        />
                    </div>

                    <div>
                        <label
                                for="street"
                                class="block text-sm font-medium text-gray-700 mb-1"
                        >Phố</label
                        >
                        <form:input
                                type="text"
                                path="street"
                                class="w-full px-3 py-2 border rounded-md shadow-sm"
                        />
                    </div>

                    <div>
                        <label
                                for="ward"
                                class="block text-sm font-medium text-gray-700 mb-1"
                        >Phường</label
                        >
                        <form:input
                                type="text"
                                path="ward"
                                class="w-full px-3 py-2 border rounded-md shadow-sm"
                        />
                    </div>

                    <div>
                        <label
                                for="district"
                                class="block text-sm font-medium text-gray-700 mb-1"
                        >Quận</label
                        >
                        <form:select
                                path="district"
                                class="w-full px-3 py-2 border rounded-md shadow-sm">
                            <form:option value="">--Chọn quận--</form:option>
                            <form:options items="${districts}"></form:options>
                        </form:select>
                    </div>

                    <div>
                        <label
                                for="city"
                                class="block text-sm font-medium text-gray-700 mb-1"
                        >Thành phố</label
                        >
                        <form:input
                                path="city"
                                class="w-full px-3 py-2 border rounded-md shadow-sm"
                        />
                    </div>

                    <div>
                        <label
                                for="latitude"
                                class="block text-sm font-medium text-gray-700 mb-1"
                        >Vĩ độ</label
                        >
                        <form:input
                                step="0.00000001"
                                path="latitude"
                                class="w-full px-3 py-2 border rounded-md shadow-sm"
                        />
                    </div>

                    <div>
                        <label
                                for="longitude"<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

                                class="block text-sm font-medium text-gray-700 mb-1"
                        >Kinh độ</label
                        >
                        <form:input
                                step="0.00000001"
                                path="longitude"
                                class="w-full px-3 py-2 border rounded-md shadow-sm"
                        />
                    </div>
                </div>
            </div>

            <!-- Pricing & Services -->
            <div class="mb-8">
                <h2 class="text-xl font-semibold text-gray-800 border-b pb-2 mb-4">
                    <i class="fas fa-money-bill-wave text-blue-500 mr-2"></i> Giá cả
                    và dịch vụ
                </h2>

                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    <div>
                        <label
                                class="block text-sm font-medium text-gray-700 mb-1"
                        >Giá thuê</label
                        >
                        <form:input
                                path="rentPrice"
                                class="w-full px-3 py-2 border rounded-md shadow-sm"
                        />
                    </div>

                    <div>
                        <label
                                for="rentpricedescription"
                                class="block text-sm font-medium text-gray-700 mb-1"
                        >Mô tả giá thuê</label
                        >
                        <form:input
                                path="rentpricedescription"
                                class="w-full px-3 py-2 border rounded-md shadow-sm"
                        ></form:input>
                    </div>

                    <div>
                        <label
                                class="block text-sm font-medium text-gray-700 mb-1"
                        >Phí dịch vụ</label
                        >
                        <form:input
                                type="text"
                                path="serviceFee"
                                class="w-full px-3 py-2 border rounded-md shadow-sm"
                        />
                    </div>

                    <div>
                        <label
                                class="block text-sm font-medium text-gray-700 mb-1"
                        >Phí xe hơi</label
                        >
                        <form:input
                                path="carFee"
                                class="w-full px-3 py-2 border rounded-md shadow-sm"
                        />
                    </div>

                    <div>
                        <label
                                class="block text-sm font-medium text-gray-700 mb-1"
                        >Phí xe máy</label
                        >
                        <form:input
                                path="motoFee"
                                class="w-full px-3 py-2 border rounded-md shadow-sm"
                        />
                    </div>

                    <div>
                        <label
                                class="block text-sm font-medium text-gray-700 mb-1"
                        >Phí quá giờ</label
                        >
                        <form:input
                                path="overtimeFee"
                                class="w-full px-3 py-2 border rounded-md shadow-sm"
                        />
                    </div>

                    <div>
                        <label
                                class="block text-sm font-medium text-gray-700 mb-1"
                        >Tiền nước</label
                        >
                        <form:input
                                path="waterFee"
                                class="w-full px-3 py-2 border rounded-md shadow-sm"
                        />
                    </div>

                    <div>
                        <label
                                class="block text-sm font-medium text-gray-700 mb-1"
                        >Tiền điện</label
                        >
                        <form:input
                                path="electricityFee"
                                class="w-full px-3 py-2 border rounded-md shadow-sm"
                        />
                    </div>

                    <div>
                        <label
                                class="block text-sm font-medium text-gray-700 mb-1"
                        >Đặt cọc</label
                        >
                        <form:input
                                path="deposit"
                                class="w-full px-3 py-2 border rounded-md shadow-sm"
                        />
                    </div>

                    <div>
                        <label
                                class="block text-sm font-medium text-gray-700 mb-1"
                        >Payment</label
                        >
                        <form:input
                                path="payment"
                                class="w-full px-3 py-2 border rounded-md shadow-sm"
                        />
                    </div>

                    <div>
                        <label
                                class="block text-sm font-medium text-gray-700 mb-1"
                        >Thời gian thuê</label
                        >
                        <form:input
                                path="rentTime"
                                class="w-full px-3 py-2 border rounded-md shadow-sm"
                        />
                    </div>

                    <div>
                        <label
                                class="block text-sm font-medium text-gray-700 mb-1"
                        >Decoration Time</label
                        >
                        <form:input
                                path="decorationTime"
                                class="w-full px-3 py-2 border rounded-md shadow-sm"
                        />
                    </div>

                    <div>
                        <label
                                class="block text-sm font-medium text-gray-700 mb-1"
                        >Phí môi giới</label
                        >
                        <form:input
                                path="brokerageFee"
                                class="w-full px-3 py-2 border rounded-md shadow-sm"
                        />
                    </div>
                </div>
            </div>

            <!-- Additional -->
            <div class="mb-8">
                <h2 class="text-xl font-semibold text-gray-800 border-b pb-2 mb-4">
                    <i class="fas fa-user-cog text-blue-500 mr-2"></i> Thông tin bổ
                    sung
                </h2>

                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    <div>
                        <label
                                class="block text-sm font-medium text-gray-700 mb-1"
                        >Tên quản lý</label
                        >
                        <form:input
                                path="managerName"
                                class="w-full px-3 py-2 border rounded-md shadow-sm"
                        />
                    </div>

                    <div>
                        <label
                                class="block text-sm font-medium text-gray-700 mb-1"
                        >Số điện thoại quản lý</label
                        >
                        <form:input
                                path="managerPhone"
                                class="w-full px-3 py-2 border rounded-md shadow-sm"
                        />
                    </div>

                    <div>
                        <label
                                class="block text-sm font-medium text-gray-700 mb-1"
                        >Ghi chú</label
                        >
                        <form:input
                                path="note"
                                class="w-full px-3 py-2 border rounded-md shadow-sm"
                        />
                    </div>
                </div>
            </div>

            <div class="space-y-4">
                <h2 class="text-xl font-semibold text-gray-800 border-b pb-2">
                    <i class="fas fa-images text-blue-500 mr-2"></i>
                    Hình ảnh tòa nhà
                </h2>

                <div
                        class="border-2 border-dashed border-gray-300 rounded-lg p-6 text-center"
                >
                    <div
                            id="imagePreview"
                            class="grid grid-cols-2 sm:grid-cols-3 gap-4 mb-4 hidden"
                    >
                        <!-- Images will be previewed here -->
                    </div>

                    <div id="uploadArea" class="cursor-pointer">
                        <i
                                class="fas fa-cloud-upload-alt text-4xl text-blue-500 mb-2"
                        ></i>
                        <p class="text-gray-600 mb-1">
                            Kéo thả hình ảnh vào đây hoặc nhấn để chọn
                        </p>
                        <p class="text-sm text-gray-500">
                            Hỗ trợ JPG, PNG (Tối đa 5MB mỗi ảnh)
                        </p>
                    </div>
                    <input
                            type="file"
                            id="imageUpload"
                            name="imageUpload"
                            multiple
                            accept="image/*"
                    />
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
                        id="btnInsertOrUpdateBuilding"
                        type="button"
                        class="px-4 py-2 text-white bg-blue-600 rounded-md hover:bg-blue-700"
                >
                    <i class="fas fa-save mr-2"></i> Lưu
                </button>
            </div>
        </form:form>
    </div>
</div>

<script>

    function uploadImagesToCloudinary(files) {
        const formData = new FormData();
        for (const file of files) {
            formData.append("files", file); // gửi nhiều file
        }

        return $.ajax({
            url: "/api/building/upload-img",
            method: "POST",
            data: formData,
            processData: false,
            contentType: false
        });
    }

    $("#btnInsertOrUpdateBuilding").click(function () {
        var data = {};
        var typeCode = [];
        var formData = $("#listForm").serializeArray();

        $.each(formData, function (i, v) {
            if (v.name != "typeCode") {
                data["" + v.name + ""] = v.value;
            } else {
                typeCode.push(v.value);
            }
        });
        data["typeCode"] = typeCode;
        if (!data.district || !data.ward || !data.numberOfBasement || !data.rentArea
            || !data.managerName || !data.managerPhone || !data.rentPrice || typeCode.length === 0) {
            alert("Vui lòng điền đầy đủ thông tin bắt buộc (quận, phường, tầng hầm, diện tích thuê, giá thuê, tên/sđt quản lý, loại tòa nhà).");
            return;
        }

        const files = document.getElementById("imageUpload").files;
        if (files.length > 0) {
            uploadImagesToCloudinary(files).then(function (urls) {
                data["imageUrls"] = urls; // gửi mảng url ảnh lên server
                insertOrUpdateBuilding(data);
            });
        } else {
            insertOrUpdateBuilding(data);
        }
    });

    function insertOrUpdateBuilding(data){
        $.ajax({
            type: "POST",
            url: "/api/building",
            data: JSON.stringify(data),
            contentType: "application/json", // đinh dạng dữ liệu từ phía client gửi về
            dataType: "JSON", // định dạng dữ liệu từ server gửi lên
            success: function (respond) {
                console.log("ok rồi nhé anh ba");
                window.location.href = "/admin/building-list";
            },
            error: function (respond) {
                console.log("lỗi rồi anh ba");
                console.log(respond);
            }
        });
    }

    $('#btnCancel').click(function (){
        window.location.href = "/admin/building-list";
    });

    document.getElementById("imageUpload").addEventListener("change", function () {
        const preview = document.getElementById("imagePreview");
        preview.innerHTML = ""; // Clear cũ trước

        const files = this.files;
        if (!files || files.length === 0) return;

        for (const file of files) {
            if (!file.type.startsWith("image/")) continue; // Bỏ qua file không phải ảnh

            const reader = new FileReader();
            reader.onload = function (e) {
                const img = document.createElement("img");
                img.src = e.target.result;
                img.style.maxWidth = "150px";
                img.style.margin = "8px";
                img.style.border = "1px solid #ccc";
                img.style.borderRadius = "8px";
                preview.appendChild(img);
            };
            reader.readAsDataURL(file); // Đọc file để tạo ảnh preview
        }
    });

</script>
</body>
</html>
