<%@ include file="/WEB-INF/views/taglib.jsp" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>PrimeProperties | Find Your Dream Property</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
    />
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: "#1e40af",
                        secondary: "#f97316",
                        dark: "#0f172a",
                        light: "#f8fafc",
                    },
                },
            },
        };
    </script>
    <style>
        @import url("https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap");
        body {
            font-family: "Inter", sans-serif;
            background-color: #f8fafc;
        }
        .hero-bg {
            background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)),
            url("https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80");
            background-size: cover;
            background-position: center;
        }
        .property-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1),
            0 10px 10px -5px rgba(0, 0, 0, 0.04);
        }
        .feature-card {
            transition: all 0.3s ease;
        }
        .feature-card:hover {
            transform: scale(1.05);
        }
        .category-card {
            transition: all 0.3s ease;
        }
        .category-card:hover {
            background-color: #e0f2fe;
        }
        .testimonial-card {
            transition: all 0.3s ease;
        }
        .testimonial-card:hover {
            transform: translateY(-5px);
        }
    </style>
</head>
<body class="bg-light">
<!-- Header -->
<header class="bg-white shadow-md sticky top-0 z-50">
    <div
            class="container mx-auto px-4 py-4 flex justify-between items-center"
    >
        <div class="flex items-center">
            <div
                    class="bg-primary w-10 h-10 rounded-lg flex items-center justify-center"
            >
                <i class="fas fa-home text-white text-2xl"></i>
            </div>
            <span class="ml-2 text-2xl font-bold text-dark"
            >Prime<span class="text-secondary">Properties</span></span
            >
        </div>

        <nav class="hidden md:flex space-x-8">
            <a
                    href="/homepage/trang-chu"
                    class="text-dark font-medium hover:text-secondary transition"
            >Trang Chủ</a
            >
            <a
                    href="/homepage/bat-dong-san"
                    class="text-dark font-medium hover:text-secondary transition"
            >Bất Động Sản</a
            >
            <a
                    href="/homepage/gioi-thieu"
                    class="text-dark font-medium hover:text-secondary transition"
            >Giới thiệu</a
            >
            <a
                    href="#"
                    class="text-dark font-medium hover:text-secondary transition"
            >Tin tức</a
            >
            <a
                    href="/homepage/lien-he"
                    class="text-dark font-medium hover:text-secondary transition"
            >Liên Hệ</a
            >
        </nav>

        <div class="flex items-center space-x-4">
            <button
                    class="hidden md:block bg-primary hover:bg-blue-800 text-white px-5 py-2 rounded-lg font-medium transition"
            >
                Đăng Tin BĐS
            </button>
            <security:authorize access="isAnonymous()">
                <!-- Khi CHƯA đăng nhập -->
                <a
                        href="/login"
                        class="bg-secondary hover:bg-orange-600 text-white px-4 py-2 rounded-lg font-medium transition"
                >
                    Đăng Nhập
                </a>
            </security:authorize>

            <security:authorize access="isAuthenticated()">
                <!-- Khi ĐÃ đăng nhập -->
                <a
                        href="/home"
                        class="bg-primary hover:bg-blue-800 text-white px-4 py-2 rounded-lg font-medium transition"
                >
                    Trang Quản Trị
                </a>
            </security:authorize>
            <button class="md:hidden text-dark">
                <i class="fas fa-bars text-2xl"></i>
            </button>
        </div>
    </div>
</header>

<!-- Contact Form Section -->
<section id="contact" class="bg-light py-16">
        <div class="container mx-auto px-4">
            <h2 class="text-3xl font-bold text-dark mb-8 text-center">
                Liên Hệ Với Chúng Tôi
            </h2>
            <form
                    id="clientForm" method="POST"
                    class="max-w-2xl mx-auto bg-white p-8 rounded-lg shadow-md space-y-6"
            >
                <div>
                    <label for="fullName" class="block text-gray-700 font-medium mb-2"
                    >Họ và Tên</label
                    >
                    <input
                            type="text"
                            id="fullName"
                            name="fullName"
                            class="w-full border border-gray-300 rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-primary"
                    />
                </div>

                <div>
                    <label for="phone" class="block text-gray-700 font-medium mb-2"
                    >Số điện thoại</label
                    >
                    <input
                            type="tel"
                            id="phone"
                            name="phone"
                            class="w-full border border-gray-300 rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-primary"
                    />
                </div>

                <div>
                    <label for="email" class="block text-gray-700 font-medium mb-2"
                    >Email</label
                    >
                    <input
                            type="email"
                            id="email"
                            name="email"
                            class="w-full border border-gray-300 rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-primary"
                    />
                </div>

                <div>
                    <label for="companyName" class="block text-gray-700 font-medium mb-2"
                    >Tên công ty</label
                    >
                    <input
                            type="text"
                            id="companyName"
                            name="companyName"
                            class="w-full border border-gray-300 rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-primary"
                    />
                </div>

                <div>
                    <label
                            for="demand"
                            class="block text-gray-700 font-medium mb-2"
                    >Nhu cầu</label
                    >
                    <textarea
                            id="demand"
                            name="demand"
                            rows="4"
                            class="w-full border border-gray-300 rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-primary"
                    ></textarea>
                </div>

                <input type="hidden" name="status" value="CHUA_XU_LY">

                <div class="text-center">
                    <button
                            type="button"
                            id="btnSend"
                            class="bg-primary hover:bg-blue-800 text-white px-6 py-2 rounded-lg font-medium transition"
                    >
                        Gửi Liên Hệ
                    </button>
                </div>
            </form>
        </div>
</section>

<!-- Footer -->
<footer class="bg-dark text-white py-12">
    <div class="container mx-auto px-4 grid grid-cols-1 md:grid-cols-4 gap-8">
        <div>
            <h3 class="font-bold text-xl mb-4">PrimeProperties</h3>
            <p class="text-gray-300">
                Mang đến giải pháp bất động sản nhanh chóng và uy tín cho mọi khách
                hàng.
            </p>
        </div>
        <div>
            <h4 class="font-bold mb-4">Liên Kết</h4>
            <ul>
                <li class="mb-2">
                    <a href="#" class="text-gray-300 hover:text-secondary transition"
                    >Trang Chủ</a
                    >
                </li>
                <li class="mb-2">
                    <a href="#" class="text-gray-300 hover:text-secondary transition"
                    >Bất Động Sản</a
                    >
                </li>
                <li class="mb-2">
                    <a href="#" class="text-gray-300 hover:text-secondary transition"
                    >Đại Lý</a
                    >
                </li>
                <li class="mb-2">
                    <a href="#" class="text-gray-300 hover:text-secondary transition"
                    >Liên Hệ</a
                    >
                </li>
            </ul>
        </div>
        <div>
            <h4 class="font-bold mb-4">Dịch Vụ</h4>
            <ul>
                <li class="mb-2">
                    <a href="#" class="text-gray-300 hover:text-secondary transition"
                    >Tư Vấn</a
                    >
                </li>
                <li class="mb-2">
                    <a href="#" class="text-gray-300 hover:text-secondary transition"
                    >Cho Thuê</a
                    >
                </li>
                <li class="mb-2">
                    <a href="#" class="text-gray-300 hover:text-secondary transition"
                    >Quản Lý</a
                    >
                </li>
            </ul>
        </div>
        <div>
            <h4 class="font-bold mb-4">Liên Hệ</h4>
            <p class="text-gray-300">54, Phố Triều Khúc, Thanh Xuân, Hà Nội</p>
            <p class="text-gray-300">Email: info@primeproperties.vn</p>
            <p class="text-gray-300">Điện thoại: +84 123 456 789</p>
        </div>
    </div>

    <div class="text-center text-gray-500 mt-8">
        &copy; 2025 PrimeProperties. Bảo lưu mọi quyền.
    </div>
</footer>

<script>

    $("#btnSend").click(function (e) {
        e.preventDefault();
        var data = {};
        var formData = $("#clientForm").serializeArray();

        $.each(formData, function (i, v) {
            data["" + v.name + ""] = v.value;

        });
        if (!data.fullName || !data.phone ) {
            alert("Vui lòng điền đầy đủ thông tin bắt buộc (tên khách hàng, số điện thoại).");
            return;
        }

        console.log(data);

        addCustomer(data);
    });

    function addCustomer(data){
        $.ajax({
            type: "POST",
            url: "/api/customer/from-contact",
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: "JSON",
            success: function (respond) {
                console.log("ok rồi nhé anh ba");
                window.location.href = "/homepage/lien-he";
            },
            error: function (response) {
                console.log("lỗi rồi anh ba");
                console.log(response);
            }
        });
    }
</script>

</body>
</html>

