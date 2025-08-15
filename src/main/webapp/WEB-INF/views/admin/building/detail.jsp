<%--
  Created by IntelliJ IDEA.
  User: LENOVO
  Date: 8/15/2025
  Time: 4:01 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/taglib.jsp" %>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Building Details</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
    />
    <style>
        .building-image {
            height: 400px;
            object-fit: cover;
            transition: transform 0.3s ease;
        }
        .building-image:hover {
            transform: scale(1.02);
        }
        .gallery-image {
            height: 100px;
            object-fit: cover;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .gallery-image:hover {
            opacity: 0.8;
            transform: translateY(-5px);
        }
        .amenity-icon {
            font-size: 1.5rem;
            margin-bottom: 0.5rem;
            color: #3b82f6;
        }
        .floor-plan {
            border: 1px solid #e5e7eb;
            border-radius: 0.5rem;
            transition: all 0.3s ease;
        }
        .floor-plan:hover {
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
        }
        #mainImage {
            background-size: cover;
            background-position: center;
        }
    </style>
</head>
<body class="bg-gray-50">
<div class="container mx-auto px-4 py-8 max-w-7xl">
    <!-- Breadcrumb -->
    <nav class="flex mb-6" aria-label="Breadcrumb">
        <ol class="inline-flex items-center space-x-1 md:space-x-3">
            <li class="inline-flex items-center">
                <a
                        href="#"
                        class="inline-flex items-center text-sm font-medium text-gray-700 hover:text-blue-600"
                >
                    <i class="fas fa-home mr-2"></i>
                    Home
                </a>
            </li>
            <li>
                <div class="flex items-center">
                    <i class="fas fa-chevron-right text-gray-400"></i>
                    <a
                            href="#"
                            class="ml-1 text-sm font-medium text-gray-700 hover:text-blue-600 md:ml-2"
                    >Buildings</a
                    >
                </div>
            </li>
            <li aria-current="page">
                <div class="flex items-center">
                    <i class="fas fa-chevron-right text-gray-400"></i>
                    <span class="ml-1 text-sm font-medium text-gray-500 md:ml-2"
                    >${buildingDetail.name}</span
                    >
                </div>
            </li>
        </ol>
    </nav>

    <!-- Building Title and Basic Info -->
    <div
            class="flex flex-col md:flex-row justify-between items-start md:items-center mb-6"
    >
        <div>
            <h1 class="text-3xl font-bold text-gray-900 mb-2">${buildingDetail.name}</h1>
            <div class="flex items-center text-gray-600">
                <i class="fas fa-map-marker-alt mr-2"></i>
                <span>${buildingDetail.address}</span>
            </div>
        </div>
        <div class="mt-4 md:mt-0 flex items-center">
            <div class="flex items-center mr-6">
                <i class="fas fa-star text-yellow-400 mr-1"></i>
                <span class="font-semibold">4.8</span>
                <span class="text-gray-500 ml-1">(128 reviews)</span>
            </div>
            <button
                    class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-lg flex items-center"
            >
                <i class="far fa-bookmark mr-2"></i> Save
            </button>
        </div>
    </div>

    <!-- Main Image and Gallery -->
    <div class="grid grid-cols-1 lg:grid-cols-4 gap-4 mb-8">
        <!-- Main Image -->
        <c:if test="${not empty buildingDetail.imageUrls}">
            <c:set var="firstImage" value="" />
            <c:forEach var="img" items="${buildingDetail.imageUrls}" varStatus="status">
                <c:if test="${status.index == 0}">
                    <c:set var="firstImage" value="${img}" />
                </c:if>
            </c:forEach>

            <div class="lg:col-span-3 rounded-xl overflow-hidden shadow-lg">
                <img
                        id="mainImage"
                        src="${firstImage}"
                        alt="Main building image"
                        class="w-full h-96 object-cover rounded-xl"
                />
            </div>
        </c:if>

        <!-- Thumbnails -->
        <div class="grid grid-cols-2 gap-2 lg:grid-cols-1">
            <c:forEach var="img" items="${buildingDetail.imageUrls}">
                <div class="rounded-lg overflow-hidden border-2 border-transparent cursor-pointer">
                    <img
                            src="${img}"
                            data-src="${img}"
                            alt="Building image"
                            class="gallery-image w-full h-24 object-cover"
                            onclick="changeMainImage(this)"
                    />
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- Building Details Section -->
    <div class="grid grid-cols-1 lg:grid-cols-3 gap-8 mb-12">
        <!-- Main Content -->
        <div class="lg:col-span-2">
            <!-- Highlights -->
            <div class="bg-white rounded-xl shadow-md p-6 mb-8">
                <h2 class="text-xl font-bold text-gray-900 mb-4">
                    Thông tin cơ bản
                </h2>
                <div class="grid grid-cols-2 md:grid-cols-3 gap-4">
                    <div class="flex items-center">
                        <i class="fas fa-building text-blue-500 mr-3"></i>
                        <div>
                            <div class="text-gray-500 text-sm">Số tầng hầm</div>
                            <div class="font-semibold">${buildingDetail.numberOfBasement}</div>
                        </div>
                    </div>
                    <div class="flex items-center">
                        <i class="fas fa-calendar-alt text-blue-500 mr-3"></i>
                        <div>
                            <div class="text-gray-500 text-sm">Năm xây</div>
                            <div class="font-semibold">${buildingDetail.yearBuilt}</div>
                        </div>
                    </div>
                    <div class="flex items-center">
                        <i class="fas fa-ruler-combined text-blue-500 mr-3"></i>
                        <div>
                            <div class="text-gray-500 text-sm">Diện tích thuê</div>
                            <div class="font-semibold">${buildingDetail.rentArea}</div>
                        </div>
                    </div>
                    <div class="flex items-center">
                        <i class="bi bi-currency-dollar text-blue-500 mr-3"></i>
                        <div>
                            <div class="text-gray-500 text-sm">Giá thuê</div>
                            <div class="font-semibold">${buildingDetail.rentPrice}</div>
                        </div>
                    </div>
                    <div class="flex items-center">
                        <i class="bi bi-dpad text-blue-500 mr-3"></i>
                        <div>
                            <div class="text-gray-500 text-sm">Hướng</div>
                            <div class="font-semibold">${buildingDetail.direction}</div>
                        </div>
                    </div>
                    <div class="flex items-center">
                        <i class="fas fa-shield-alt text-blue-500 mr-3"></i>
                        <div>
                            <div class="text-gray-500 text-sm">Loại tòa nhà</div>
                            <div class="font-semibold">
                                <c:forEach var="type" items="${buildingDetail.typeCode}" varStatus="loop">
                                    ${buildingTypes[type]}<c:if test="${!loop.last}">, </c:if>
                                </c:forEach>
                            </div>

                        </div>
                    </div>
                </div>
            </div>

            <!-- Description -->
            <div class="bg-white rounded-xl shadow-md p-6 mb-8">
                <h2 class="text-xl font-bold text-gray-900 mb-4">Mô tả</h2>
                <p class="text-gray-700 mb-4">
                    ${buildingDetail.note}
                </p>
            </div>

            <!-- Amenities -->
            <div class="bg-white rounded-xl shadow-md p-6 mb-8">
                <h2 class="text-xl font-bold text-gray-900 mb-4">Tiện ích</h2>
                <div class="grid grid-cols-2 md:grid-cols-4 gap-6">
                    <div class="text-center">
                        <div class="amenity-icon"><i class="fas fa-wifi"></i></div>
                        <div>High-speed WiFi</div>
                    </div>
                    <div class="text-center">
                        <div class="amenity-icon"><i class="fas fa-utensils"></i></div>
                        <div>Food Court</div>
                    </div>
                    <div class="text-center">
                        <div class="amenity-icon"><i class="fas fa-dumbbell"></i></div>
                        <div>Fitness Center</div>
                    </div>
                    <div class="text-center">
                        <div class="amenity-icon"><i class="fas fa-coffee"></i></div>
                        <div>Café</div>
                    </div>
                    <div class="text-center">
                        <div class="amenity-icon">
                            <i class="fas fa-concierge-bell"></i>
                        </div>
                        <div>Concierge</div>
                    </div>
                    <div class="text-center">
                        <div class="amenity-icon"><i class="fas fa-leaf"></i></div>
                        <div>Green Spaces</div>
                    </div>
                    <div class="text-center">
                        <div class="amenity-icon">
                            <i class="fas fa-swimming-pool"></i>
                        </div>
                        <div>Rooftop Pool</div>
                    </div>
                    <div class="text-center">
                        <div class="amenity-icon">
                            <i class="fas fa-charging-station"></i>
                        </div>
                        <div>EV Charging</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Sidebar -->
        <div class="lg:col-span-1">
            <!-- Contact Card -->
            <div class="bg-white rounded-xl shadow-md p-6 sticky top-4 mb-6">
                <h2 class="text-xl font-bold text-gray-900 mb-4">
                    Liên hệ quản lý
                </h2>
                <div class="flex items-center mb-4">
                    <div
                            class="w-12 h-12 rounded-full bg-blue-100 flex items-center justify-center mr-4"
                    >
                        <i class="fas fa-user-tie text-blue-600 text-xl"></i>
                    </div>
                    <div>
                        <div class="font-semibold">${buildingDetail.managerName}</div>
                        <div class="text-gray-500 text-sm">Chủ nhà</div>
                    </div>
                </div>
                <div class="space-y-3">
                    <div class="flex items-center text-gray-700">
                        <i class="fas fa-phone-alt mr-3 text-blue-500"></i>
                        <span>${buildingDetail.managerPhone}</span>
                    </div>
                </div>
            </div>

            <!-- Location Map -->
            <div class="bg-white rounded-xl shadow-md p-6 mb-6">
                <h2 class="text-xl font-bold text-gray-900 mb-4">Địa chỉ</h2>
                <a href="https://www.google.com/maps?q=${buildingDetail.latitude},${buildingDetail.longitude}"
                   target="_blank"
                   class="flex items-center text-blue-600 hover:underline">
                    <img src="https://cdn-icons-png.flaticon.com/512/684/684908.png"
                         alt="Map icon"
                         style="width:20px;height:20px;margin-right:6px;">
                    ${buildingDetail.address}
                </a>
            </div>
        </div>
    </div>
</div>

<script>
    function changeMainImage(element) {
        const mainImage = document.getElementById("mainImage");
        const newUrl = element.getAttribute("data-src");
        mainImage.src = newUrl;

        document.querySelectorAll(".gallery-image").forEach(img => {
            img.parentElement.classList.remove("border-blue-500");
        });
        element.parentElement.classList.add("border-blue-500");
    }

    document.addEventListener("DOMContentLoaded", () => {
        const firstThumb = document.querySelector(".gallery-image");
        if (firstThumb) firstThumb.parentElement.classList.add("border-blue-500");
    });
</script>

</body>
</html>
