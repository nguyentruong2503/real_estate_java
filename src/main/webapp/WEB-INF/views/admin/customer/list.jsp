<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/taglib.jsp" %>
<c:url var="customerListURL" value="/admin/customer-list"/>
<c:url var="customerAPI" value="/api/customer"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Customer Management</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
    />
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: "#3B82F6",
                        secondary: "#1E40AF",
                        accent: "#10B981",
                        dark: "#1F2937",
                        light: "#F9FAFB",
                    },
                },
            },
        };
    </script>
    <style>
        .content {
            transition: all 0.3s ease;
        }
        .content.expanded {
            margin-left: 70px;
        }
        @media (max-width: 768px) {
            .sidebar {
                position: absolute;
                z-index: 100;
                left: -250px;
            }
            .sidebar.active {
                left: 0;
            }
            .content.expanded {
                margin-left: 0;
            }
        }

        /* Search dropdown animation */
        .search-dropdown {
            opacity: 0;
            transform: translateY(-10px);
            transition: all 0.2s ease;
            pointer-events: none;
        }
        .search-dropdown.show {
            opacity: 1;
            transform: translateY(0);
            pointer-events: auto;
        }

        .pagebanner {
            display: none; /* Ẩn text "8 items found..." */
        }
        .pagelinks {
            display: none; /* Ẩn nút phân trang mặc định */
        }

        /* Custom animation for modal */
        @keyframes modalFadeIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .modal-animation {
            animation: modalFadeIn 0.3s ease-out forwards;
        }

        /* Custom scrollbar for employee list */
        .employee-list::-webkit-scrollbar {
            width: 6px;
        }

        .employee-list::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 10px;
        }

        .employee-list::-webkit-scrollbar-thumb {
            background: #888;
            border-radius: 10px;
        }

        .employee-list::-webkit-scrollbar-thumb:hover {
            background: #555;
        }

    </style>
</head>
<body class="bg-gray-100 font-sans">

<main class="flex-1 overflow-y-auto p-4 md:p-6 bg-gray-50">
    <!-- Page Header -->
    <div
            class="flex flex-col md:flex-row justify-between items-start md:items-center mb-6 gap-4"
    >
        <div>
            <h2 class="text-2xl font-bold text-gray-800">Customer Management</h2>
            <p class="text-sm text-gray-500 mt-1">
                Manage all your customer
            </p>
        </div>

        <div class="flex flex-col md:flex-row gap-3 w-full md:w-auto">
            <!-- Advanced Search Button -->
            <button
                    id="advancedSearchToggle"
                    class="flex items-center justify-center md:justify-start text-primary border border-primary bg-white hover:bg-blue-50 px-4 py-2 rounded-lg"
            >
                <i class="fas fa-sliders-h mr-2"></i>
                <span>Advanced Search</span>
            </button>

            <a href="/admin/customer-edit">
                <button
                        class="bg-primary hover:bg-blue-700 text-white px-4 py-2 rounded-lg flex items-center justify-center"
                >
                    <i class="fas fa-plus mr-2"></i>
                    Thêm mới khách hàng
                </button>
            </a>

        </div>
    </div>

    <!-- Advanced Search Panel -->
    <div
            id="advancedSearchPanel"
            class="bg-white rounded-lg shadow overflow-hidden mb-6 hidden transition-all duration-300"
    >
        <div
                class="p-4 border-b border-gray-200 flex justify-between items-center"
        >
            <h3 class="font-medium text-gray-800">Tìm kiếm nâng cao</h3>
            <button
                    id="closeAdvancedSearch"
                    class="text-gray-500 hover:text-gray-700"
            >
                <i class="fas fa-times"></i>
            </button>
        </div>

        <!-- Form Grid -->

        <form:form id="listForm" modelAttribute="customerDTO" action="${customerListURL}" method="GET"
                   class="p-4 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4" >
            <!-- Tên tòa nhà -->
            <div>
                <label
                        class="block text-sm font-medium text-gray-700 mb-1"
                >Tên khách hàng</label
                >
                <form:input path="fullName"
                            type="text"
                            class="w-full border px-3 py-2 rounded-md"
                            placeholder="Nhập tên khách hàng"
                />
            </div>

            <div>
                <label
                        class="block text-sm font-medium text-gray-700 mb-1"
                >Số điện thoại</label
                >
                <form:input
                        type="number"
                        path="phone"
                        class="w-full border px-3 py-2 rounded-md"
                        placeholder="Số điện thoại"
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
                        class="w-full border px-3 py-2 rounded-md"
                        placeholder="Email"
                />
            </div>

            <div class="col-span-full">
                <security:authorize access="hasRole('MANAGER')">
                    <label
                            class="block text-sm font-medium text-gray-700 mb-1"
                    >Chọn nhân viên phụ trách</label
                    >
                    <form:select path="staffId" class="w-full border px-3 py-2 rounded-md">
                        <form:option value="">--Chọn nhân viên--</form:option>
                        <form:options items="${listStaffs}"></form:options>
                    </form:select>
                </security:authorize>
            </div>

            <div
                    class="p-4 bg-gray-50 border-t border-gray-200 flex justify-end gap-3"
            >
                <button
                        type="reset"
                        id="resetSearch"
                        class="px-4 py-2 text-gray-700 hover:text-gray-900 rounded-lg border"
                >
                    Reset
                </button>
                <button
                        id="btnSearchCustomer"
                        class="px-4 py-2 bg-blue-600 hover:bg-blue-700 text-white rounded-lg"
                >
                    Tìm kiếm
                </button>
            </div>
        </form:form>

    </div>

    <div class="bg-white rounded-lg shadow overflow-hidden">
        <div class="overflow-x-auto">
            <table id="tableList" class="min-w-full divide-y divide-gray-200">
                <display:table
                        name="customerDTO.listResult"
                        requestURI="${customerListURL}"
                        partialList="true"
                        sort="external"
                        size="${customerDTO.totalItems}"
                        defaultsort="1"
                        defaultorder="ascending"
                        id="tableList"
                        pagesize="${customerDTO.maxPageItems}"
                        export="false"
                        class="min-w-full divide-y divide-gray-200"
                >
                    <display:column property="id" style="display:none;" headerClass="hidden" class="hidden"/>

                    <display:column title="Tên khách hàng" property="fullName"
                                    headerClass="px-6 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider"
                                    class="px-6 py-4 text-sm text-gray-500"/>

                    <display:column title="SĐT" property="phone"
                                    headerClass="px-6 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider"
                                    class="px-6 py-4 text-sm text-gray-500"/>

                    <display:column title="Email" property="email"
                                    headerClass="px-6 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider"
                                    class="px-6 py-4 text-sm text-gray-500" />

                    <display:column title="Nhu cầu" property="demand"
                                    headerClass="px-6 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider"
                                    class="px-6 py-4 text-sm text-gray-500"/>

                    <display:column title="Người thêm" property="createdBy"
                                    headerClass="px-6 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider"
                                    class="px-6 py-4 text-sm text-gray-500"/>

                    <display:column title="Ngày thêm" property="createdDate"
                                    headerClass="px-6 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider"
                                    class="px-6 py-4 text-sm text-gray-500"/>

                    <display:column title="Người sửa" property="modifiedBy"
                                    headerClass="px-6 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider"
                                    class="px-6 py-4 text-sm text-gray-500"/>

                    <display:column title="Ngày sửa" property="modifiedDate"
                                    headerClass="px-6 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider"
                                    class="px-6 py-4 text-sm text-gray-500"/>

                    <display:column title="Trạng thái"
                                    headerClass="px-6 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider"
                                    class="px-6 py-4 text-sm text-gray-500">

                        <c:choose>
                            <c:when test="${tableList.status == 'CHUA_XU_LY'}">Chưa xử lý</c:when>
                            <c:when test="${tableList.status == 'DA_XU_LY'}">Đã xử lý</c:when>
                            <c:when test="${tableList.status == 'DANG_XU_LY'}">Đang xử lý</c:when>
                        </c:choose>
                    </display:column>


                    <display:column title="Thao tác" headerClass="px-6 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider text-center">
                        <div class="flex space-x-2 justify-center">
                            <a class="text-blue-600 hover:text-blue-900" href="/admin/customer-edit-${tableList.id}" title="Sửa">
                                <i class="fas fa-edit"></i>
                            </a>
                            <security:authorize access="hasRole('MANAGER')">
                                <button class="text-red-600 hover:text-red-900" onclick="deleteCustomer(${tableList.id})" title="Xóa">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </security:authorize>
                            <security:authorize access="hasRole('MANAGER')">
                                <button class="text-purple-600 hover:text-purple-900" onclick="assignmentCustomer(${tableList.id})" title="Giao khách hàng">
                                    <i class="fas fa-user-tag"></i>
                                </button>
                            </security:authorize>
                        </div>
                    </display:column>
                </display:table>
            </table>
        </div>
    </div>

    <!-- Pagination -->
    <div class="flex items-center justify-between mt-6 bg-white px-4 py-3 rounded-lg shadow">
        <div class="hidden sm:flex-1 sm:flex sm:items-center sm:justify-between">
            <div>
                <p class="text-sm text-gray-700">
                    Showing
                    <span class="font-medium">${(customerDTO.page - 1) * customerDTO.maxPageItems + 1}</span>
                    to
                    <span class="font-medium">
                    <c:choose>
                        <c:when test="${customerDTO.page * customerDTO.maxPageItems > customerDTO.totalItems}">
                            ${customerDTO.totalItems}
                        </c:when>
                        <c:otherwise>
                            ${customerDTO.page * customerDTO.maxPageItems}
                        </c:otherwise>
                    </c:choose>
                </span>
                    of
                    <span class="font-medium">${customerDTO.totalItems}</span> customers
                </p>
            </div>

            <div>
                <nav class="relative z-0 inline-flex rounded-md shadow-sm -space-x-px" aria-label="Pagination">
                    <!-- Previous -->
                    <c:if test="${customerDTO.page > 1}">
                        <c:url var="prevUrl" value="${customerListURL}">
                            <c:param name="d-3677046-p" value="${customerDTO.page - 1}" />
                        </c:url>
                        <a href="${prevUrl}"
                           class="relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                            <i class="fas fa-chevron-left"></i>
                        </a>
                    </c:if>

                    <!-- Page numbers -->
                    <c:forEach var="i" begin="1" end="${customerDTO.totalPage}">
                        <c:url var="pageUrl" value="${customerListURL}">
                            <c:param name="d-3677046-p" value="${i}" />
                        </c:url>
                        <a href="${pageUrl}"
                           class="${i == customerDTO.page ? 'z-10 bg-primary border-primary text-white' : 'bg-white border-gray-300 text-gray-500 hover:bg-gray-50'} relative inline-flex items-center px-4 py-2 border text-sm font-medium">
                                ${i}
                        </a>
                    </c:forEach>

                    <!-- Next -->
                    <c:if test="${customerDTO.page < customerDTO.totalPage}">
                        <c:url var="nextUrl" value="${customerListURL}">
                            <c:param name="d-3677046-p" value="${customerDTO.page + 1}" />
                        </c:url>
                        <a href="${nextUrl}"
                           class="relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                            <i class="fas fa-chevron-right"></i>
                        </a>
                    </c:if>

                </nav>
            </div>
        </div>
    </div>

    <div id="assignmentModal" class="fixed inset-0 z-50 hidden overflow-y-auto">
        <div
                class="flex items-center justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0"
        >
            <!-- Background overlay -->
            <div class="fixed inset-0 transition-opacity" aria-hidden="true">
                <div class="absolute inset-0 bg-gray-500 opacity-75"></div>
            </div>

            <!-- Modal container -->
            <div
                    class="inline-block align-bottom bg-white rounded-lg text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-lg sm:w-full modal-animation"
            >
                <!-- Modal header -->
                <div
                        class="bg-blue-600 px-4 py-3 sm:px-6 sm:flex sm:items-center sm:justify-between"
                >
                    <h3 class="text-lg leading-6 font-medium text-white">
                        Assign customer to Employees
                    </h3>
                    <button
                            onclick="closeModal()"
                            class="text-white hover:text-gray-200 focus:outline-none"
                    >
                        <i class="fas fa-times"></i>
                    </button>
                </div>

                <!-- Modal content -->
                <div class="px-4 pt-5 pb-4 sm:p-6">
                    <!-- Employee list header -->
                    <div
                            class="grid grid-cols-12 gap-3 bg-gray-100 p-2 rounded-t-lg border-b border-gray-200"
                    >
                        <div
                                class="col-span-2 text-center text-xs font-medium text-gray-500"
                        >
                            Select
                        </div>
                        <div class="col-span-10 text-xs font-medium text-gray-500">
                            Full Name
                        </div>
                    </div>

                    <!-- Employee list with checkboxes -->
                    <div
                            class="employee-list max-h-96 overflow-y-auto border border-gray-200 rounded-b-lg"
                    >
                        <%--                    Render data nhân viên vào đây--%>
                    </div>

                    <!-- Select all option -->
                    <div class="mt-3 flex items-center">
                        <input
                                id="selectAll"
                                type="checkbox"
                                class="h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300 rounded"
                        />
                        <label for="selectAll" class="ml-2 text-sm text-gray-700"
                        >Select all employees</label
                        >
                    </div>
                    <input type="hidden" id="customerId" name="customerId" value="" />
                </div>

                <!-- Modal footer -->
                <div class="bg-gray-50 px-4 py-3 sm:px-6 sm:flex sm:flex-row-reverse">
                    <button
                            type="button"
                            id="btnAssignCustomer"
                            class="w-full inline-flex justify-center rounded-md border border-transparent shadow-sm px-4 py-2 bg-blue-600 text-base font-medium text-white hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 sm:ml-3 sm:w-auto sm:text-sm"
                    >
                        Assign Customer
                    </button>
                    <button
                            type="button"
                            onclick="closeModal()"
                            class="mt-3 w-full inline-flex justify-center rounded-md border border-gray-300 shadow-sm px-4 py-2 bg-white text-base font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 sm:mt-0 sm:ml-3 sm:w-auto sm:text-sm"
                    >
                        Cancel
                    </button>
                </div>
            </div>
        </div>
    </div>


</main>

<script>
    const advancedSearchToggle = document.getElementById(
        "advancedSearchToggle"
    );
    const advancedSearchPanel = document.getElementById(
        "advancedSearchPanel"
    );
    const closeAdvancedSearch = document.getElementById(
        "closeAdvancedSearch"
    );

    // Mở hoặc ẩn panel tìm kiếm nâng cao
    advancedSearchToggle.addEventListener("click", () => {
        advancedSearchPanel.classList.toggle("hidden");
    });

    // Đóng panel khi nhấn nút đóng
    closeAdvancedSearch.addEventListener("click", () => {
        advancedSearchPanel.classList.add("hidden");
    });


    $('#btnSearchCustomer').click(function (e){
        e.preventDefault();
        $('#listForm').submit();
    });

    function deleteCustomer(id) {
        var customerId = [id];
        deleteCustomers(customerId);
    }

    function deleteCustomers(data){
        $.ajax({
            type: "DELETE",
            url: "${customerAPI}/" +data,
            data: JSON.stringify(data),
            success: function (response) {
                console.log("ok rồi nhé anh ba");
                data.forEach(function(id) {
                    $("#tableList tbody tr").filter(function() {
                        return $(this).find("td.hidden").text().trim() == id;
                    }).remove();
                });

            },
            error: function (response) {
                console.log("lỗi rồi anh ba");
                console.log(response);
            }
        });
    }

    function closeModal() {
        document.getElementById("assignmentModal").classList.add("hidden");
        document.body.classList.remove("overflow-hidden");
    }

    document
        .getElementById("selectAll")
        .addEventListener("change", function (e) {
            const checkboxes = document.querySelectorAll(
                '.employee-list input[type="checkbox"]'
            );
            checkboxes.forEach((checkbox) => {
                checkbox.checked = e.target.checked;
            });
        });

    function assignmentCustomer(customerId) {
        document.getElementById("assignmentModal").classList.remove("hidden");
        document.body.classList.add("overflow-hidden"); // khóa cuộn trang khi mở modal
        $("#customerId").val(customerId);
        loadStaff(customerId);
    }

    function loadStaff(customerId) {
        $.ajax({
            type: "GET",
            url: "${customerAPI}/" +customerId + '/staffs',
            dataType: "JSON",
            success: function (response) {
                if (!response.data || response.data.length === 0) {
                    $(".employee-list").html(`
                    <div class="p-3 text-sm text-gray-500 text-center">
                        Không có nhân viên nào
                    </div>
                `);
                    console.warn("Không có dữ liệu nhân viên");
                    return;
                }

                var html = '';
                $.each(response.data, function(index, item) {
                    html += `
                        <div class="grid grid-cols-12 gap-4 p-3 hover:bg-gray-50 border-b border-gray-100">
                            <div class="col-span-2 flex items-center justify-center">
                                <input type="checkbox"
                                    value="\${item.staffId}"
                                    class="h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300 rounded"
                                    \${item.checked == "checked" ? "checked" : ""} />
                            </div>
                            <div class="col-span-10 text-sm text-gray-700 flex items-center">
                                \${item.fullName}
                            </div>
                        </div>
                    `;
                });
                $(".employee-list").html(html);

            },
            error: function (xhr) {
                $(".employee-list").html(`
                <div class="p-3 text-sm text-red-500 text-center">
                    Lỗi khi tải danh sách nhân viên
                </div>
            `);
                console.error("Lỗi khi load staff", xhr);
            }
        });
    }

    $("#btnAssignCustomer").click(function (e) {
        e.preventDefault();
        var data = {};
        data["customerId"] = $("#customerId").val();
        var staffs = $(".employee-list input[type=checkbox]:checked")
            .map(function () {
                return $(this).val();
            })
            .get();
        data["staffs"] = staffs;
        if(data["staffs"] != ""){
            assignTask(data);
        }
        console.log("kkk");
    });

    function assignTask(data){
        $.ajax({
            type: "POST",
            url: "${customerAPI}/" +"assignment",
            data: JSON.stringify(data),
            contentType: "application/json", // đinh dạng dữ liệu từ phía client gửi về
            dataType: "JSON", // định dạng dữ liệu từ server gửi lên
            success: function (resonse) {
                console.log("ok rồi nhé anh ba");
                window.location.href = "/admin/customer-list";
            },
            error: function (response) {
                console.info("giao tòa nhà lỗi rồi anh ba");
                window.location.href = "<c:url value="/admin/customer-list?message=error"/>";
                console.log(response);
            }
        });
    }
</script>
</body>
</html>

