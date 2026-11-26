# Clothing Rental System · Java Swing UI

Giao diện dành cho nhân viên cửa hàng cho thuê trang phục. Bốn màn hình dùng chung dữ liệu trong bộ nhớ của cửa sổ đang mở. Mỗi lần khởi động, ứng dụng bắt đầu với 6 trang phục, 2 khách hàng mẫu và sổ thuê trống. Bạn có thể hoàn thành một lượt thuê và trả ngay trên máy.

## 1. Chạy nhanh trên Windows

1. Giải nén toàn bộ file ZIP bằng **Extract All**.
2. Mở thư mục **ClothingRentalUI**. Bạn sẽ thấy `ClothingRentalUI.jar`, `Run-Windows.cmd`, `pom.xml`, `src` và `report`.
3. Dùng **JDK 17 trở lên**. Để kiểm tra, mở PowerShell và chạy `java -version`. Nếu Windows chưa nhận lệnh, cài JDK 17, thêm thư mục `bin` của JDK vào `Path` và mở lại PowerShell.
4. Nhấp đúp **Run-Windows.cmd**. Cửa sổ **Clothing Rental System** mở ở màn hình **Clothing catalog**.

Bạn cũng có thể mở PowerShell trong thư mục chứa JAR và chạy lệnh sau.

```powershell
java -jar .\ClothingRentalUI.jar
```

## 2. Mở mã nguồn trong IntelliJ IDEA

1. Giải nén ZIP. Trong IntelliJ, chọn **File → Open**, mở thư mục **ClothingRentalUI** có `pom.xml`.
2. Trong **File → Project Structure → Project**, chọn **JDK 17** làm **SDK**. Nếu IntelliJ chưa nhận project Maven, nhấn chuột phải vào `pom.xml` rồi chọn **Add as Maven Project** nếu mục này xuất hiện.
3. Mở **src → main → java → rental → Main.java**.
4. Nhấn nút Run cạnh `public static void main(String[] args)` và chọn **Run 'Main.main()'**. Sau khi sửa mã nguồn, chạy lại từ đây để xem thay đổi.

Nếu đã cài Maven, chạy `mvn package` ở thư mục chứa `pom.xml` để đóng gói lại. JAR mới nằm ở `target/ClothingRentalUI.jar`. Khi có bản này, `Run-Windows.cmd` sẽ ưu tiên chạy nó.

Để tự biên dịch bằng JDK, mở PowerShell tại thư mục project và chạy các dòng sau. Sau khi tạo JAR, mở lại **Run-Windows.cmd**.

```powershell
New-Item -ItemType Directory -Force .\target\classes | Out-Null
$javaSources = (Get-ChildItem .\src\main\java -Recurse -Filter *.java -File).FullName
javac --release 17 -encoding UTF-8 -d .\target\classes $javaSources
if ($LASTEXITCODE -eq 0) {
    jar --create --file .\target\ClothingRentalUI.jar --main-class rental.Main -C .\target\classes .
}
```

## 3. Demo đủ bốn màn hình

| Bước | Thao tác | Kết quả cần quan sát |
| --- | --- | --- |
| 1 · Catalog | Chọn **C101 · Olive linen jacket**, nhấn **Add to rental**. | **Current draft** có một món với đơn giá 120.000 VND/ngày. Áo vẫn là **Available** trong khi phiếu đang soạn. |
| 2 · Customers | Nhập **Linh Tran** và **0900000003**, nhấn **Save customer**, rồi nhấn **Use for rental**. | Khách mới nhận mã **CU003** trong phiên mới. **New rental** mở với khách và chiếc áo đã chọn. |
| 3 · New rental | Đặt **Return due** sau **Pickup date** đúng hai ngày, theo định dạng `YYYY-MM-DD`. Kiểm tra số tiền rồi nhấn **Confirm rental**. | Hai ngày mốc đều được tính phí. Ba ngày × 120.000 VND = **360.000 VND**. Sổ thuê mở ở phiếu **R001 · Open**, C101 chuyển sang **Rented**. |
| 4 · Rental ledger | Chọn **R001**, nhấn **Mark returned**, rồi **Confirm return**. Quay lại **Catalog** và tìm C101. | Phiếu chuyển sang **Returned**. Áo trở về **Available** và có thể được chọn cho lượt thuê mới. |

**Thử tình huống nhập sai.** Nhập lại số `+84 900 000 003` ở màn hình Customers. Giao diện sẽ nhận ra số đã đăng ký dù cách viết khác. Ở New rental, thử nhập `2026-02-31` hoặc ngày trước ngày nhận. Giao diện chỉ rõ lỗi và khóa nút **Confirm rental** đến khi ngày hợp lệ.

## 4. Cách đọc mã nguồn

| Tệp trong `src/main/java/rental/` | Nội dung |
| --- | --- |
| `Main.java` | Điểm chạy chương trình. Tạo cửa sổ Swing trên luồng giao diện. |
| `ui/RentalDesk.java` | Thanh điều hướng, chuyển màn hình và thông báo sau thao tác. |
| `ui/CatalogPage.java` | Tìm, lọc trang phục và thêm món vào phiếu nháp. |
| `ui/CustomersPage.java` | Tìm khách, đăng ký và chuyển khách đã chọn sang phiếu nháp. |
| `ui/CheckoutPage.java` | Chọn khách, thêm hoặc bỏ món, nhập ngày và xem báo giá. |
| `ui/LedgerPage.java` | Lọc phiếu, xem chi tiết và xác nhận trả toàn bộ món trên phiếu. |
| `ui/DemoSession.java` | Dữ liệu mẫu, phiếu nháp và trạng thái thuê–trả của riêng phiên giao diện đang mở. |
| `ui/Ui.java` | Kiểu chữ, màu, bảng và các thành phần giao diện dùng chung. |

Khi xác nhận thuê, phiếu giữ danh sách món, ngày và giá đã thỏa thuận. Trả đồ sớm hoặc muộn giữ nguyên số tiền trên phiếu. Đóng ứng dụng sẽ xóa dữ liệu của phiên. Mã nguồn dùng Java SE và Swing, chạy hoàn toàn trên máy người dùng.

## 5. Phần báo cáo tiếng Anh

Trong thư mục `report`, tệp Word có thể ghép vào báo cáo nhóm. Tệp PDF dùng để xem hoặc in. Mục **VIII.4 Graphical User Interface** gồm bảng thứ tự bốn màn hình, ảnh chụp thực tế và giải thích sự kiện nút bấm. Mục **IX Conclusion** gồm tự đánh giá và đề xuất cải tiến giao diện. Ảnh PNG gốc nằm trong `report/figures`.
