# DriveX_CKC-App

App điều khiển xe thông qua Bluetooth hoặc gửi lệnh lên Firebase Realtime Database

Sử dụng công cụ FLUTTER
## 📱 Giao diện Ứng dụng

### 1. Màn hình chính & Điều khiển (Home & Controls)
<img width="1908" height="858" alt="home" src="https://github.com/user-attachments/assets/dadc30f6-eb67-4992-8ce3-5a908ce3df28" />

### 2. Cài đặt chung (Settings)
<img width="1908" height="858" alt="settings" src="https://github.com/user-attachments/assets/3313b4f7-e877-4322-8891-d0f815fb6625" />

### 3. Chọn chế độ kết nối (Connection Modes)
<img width="1908" height="858" alt="chế độ kết nối" src="https://github.com/user-attachments/assets/bc8cd4c9-cf96-44ba-9858-5a8264f16a80" />

### 4. Kết nối Bluetooth (Bluetooth Selection & Search)
* **Chọn kiểu Bluetooth:**
<img width="1908" height="858" alt="bluetooth" src="https://github.com/user-attachments/assets/fa2efc81-699e-402b-9c10-484eedf00b1c" />

* **Quét Bluetooth Classic:**
<img width="1908" height="858" alt="bluetooth_classic_search" src="https://github.com/user-attachments/assets/8d82b533-3745-4c0d-bc9e-4ebe356c5d22" />

* **Quét Bluetooth BLE:**
<img width="1908" height="858" alt="bluetooth_BLE_search" src="https://github.com/user-attachments/assets/2d6eb52a-9383-4976-94b4-9647db4e9404" />

* **Trạng thái kết nối BLE & Cấu hình UUID:**
<img width="1908" height="858" alt="bluetooth_BLE_connected" src="https://github.com/user-attachments/assets/c24e26ee-1a74-4783-85a5-ddbf27700b86" />

### 5. Kết nối Firebase Realtime Database
<img width="1908" height="858" alt="firebase" src="https://github.com/user-attachments/assets/1655fb6c-6251-44b7-ae84-76b821fb14a3" />

### 6. Cấu hình lệnh điều khiển (TX/RX Settings)
* **Lựa chọn chế độ TX - RX:**
<img width="1908" height="858" alt="cau_hinh_lenh_dieu_khien" src="https://github.com/user-attachments/assets/e9593aaa-0626-4a31-9242-3cda0a453ad3" />

* **Cấu hình lệnh gửi (Cạnh lên / Cạnh xuống / ON / OFF):**
<img width="1908" height="858" alt="cau_hinh_lenh_gui" src="https://github.com/user-attachments/assets/9ec15917-7913-471b-9e2a-f6d5255d8f42" />

### 7. Tùy chỉnh nâng cao (Advanced Settings)
* **Điều chỉnh thao tác & vị trí nút bấm trực quan:**
<img width="1908" height="858" alt="dieu_chinh_thao_tac_dk" src="https://github.com/user-attachments/assets/3e07b6fc-cb67-4b2c-9833-81bcb77bfc4a" />

* **Tùy chỉnh màu sắc giao diện:**
<img width="1908" height="858" alt="chinh_mau" src="https://github.com/user-attachments/assets/3d9ce2c9-83d8-4904-9a75-17d71d9acc67" />

* **Cài đặt Tên nhóm & Đường dẫn Path:**
<img width="1908" height="858" alt="ten_nhom_path" src="https://github.com/user-attachments/assets/cf78787f-b9cb-4b65-88a8-91d05fe2ecd3" />

* **Phông chữ, Hiển thị Nhiệt độ (LM35) & Logo:**
<img width="1908" height="858" alt="phongchu_nhietdo_logo" src="https://github.com/user-attachments/assets/0588e05b-25b0-441c-b78b-ce2e5948ef70" />

---

## 🚀 Tính năng nổi bật
* **Đa dạng kết nối:** Hỗ trợ điều khiển thiết bị phần cứng qua **Bluetooth Classic** (SPP) hoặc **Bluetooth Low Energy (BLE)**, bên cạnh đó hỗ trợ đồng bộ dữ liệu thời gian thực qua **Firebase Realtime Database**.
* **Tùy biến linh hoạt:** Cho phép kéo thả, thay đổi vị trí, kích thước các nút điều khiển trực tiếp trên màn hình giao diện.
* **Cấu hình lệnh phong phú:** Thiết lập linh hoạt mã lệnh gửi cho các sự kiện nút nhấn (cạnh lên/cạnh xuống) và trạng thái công tắc (ON/OFF).
* **Giám sát cảm biến:** Tích hợp hiển thị thông tin nhiệt độ từ cảm biến (LM35).
