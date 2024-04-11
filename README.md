# Tutorial 6 - Menu and In-Game Graphical User Interface

Name : Felix Tjahyadi

NPM : 2106638614

Godot version : 3.5

# Latihan Mandiri

## Tombol Main Menu
Untuk latihan mandiri yang pertama ialah menambahkan sebuah tombol untuk menuju menu utama setelah pemain berada pada layar "Game Over". Berikut langkah pengerjaan yang saya lakukan:

- Pertama yang saya lakukan adalah pembuatan tombol. Tombol yang saya gunakan memanfaatkan child node "Link Button" yang juga digunakan untuk menu utama. 
- Kemudian saya mulai mengisi konfigurasi dari tombol yang berupa tulisan "Menu" dan juga mengatur posisi dari tombol. Tidak hanya itu, saya juga tambahkan konfigurasi Font yang telah dibuat.
- Terakhir saya tambahkan sebuah script yang akan melakukan pemindahan scene kembali ke menu utama yang mana ter-connect pada saat pemain menekan tombol tersebut. Berikut code dalam script tersebut:
```
extends LinkButton

export(String) var scene_to_load

func _on_LinkButton_pressed():
	get_tree().change_scene(str("res://scenes/" + scene_to_load + ".tscn"))
```
## Select Stage
Berikutnya adalah pembuatan fungsi untuk melakukan select stage bagi pemain. Berikut langkah-langkah pengerjaan yang saya lakukan:

### Langkah Awal
- Pada langkah awal, saya membuat sebuah scene baru yang akan menjadi menu untuk memilih level bermain.
- Menu tersebut dirancang menggunakan teknik yang kurang lebih sama dengan menu utama yang mana terdiri atas beberapa container dalam sebuah MarginContainer dengan Label untuk judul pada menu dan 2 buah LinkButton untuk kedua level yang ada.

### Langkah 1: Konfigurasi Elemen
- Pada Label saya berikan tulisan "Stage Select" dan memberikan Font yang sesuai
- Pada kedua LinkButton saya berikan tulisan sesuai dengan level yang ada yaitu "Level 1" dan juga "Level 2"
- Terakhir saya juga tambahkan sebuah background berwarna dengan ColorRect

### Langkah 2: Scripting
- Saya menghubungkan menu utama dan menu select stage dengan menggunakan tombol yang sudah ada dan saya berikan sebuah script berupa
```
extends LinkButton

export(String) var scene_to_load

func _on_Stage_Select_pressed():
	get_tree().change_scene(str("res://scenes/" + scene_to_load + ".tscn"))
```
- Kemudian saya hubungkan masing-masing tombol untuk setiap level dengan kode pada script
```
extends LinkButton

func _on_LinkButton_pressed():
	Transition.change_scene("res://scenes/Level 1.tscn")
```
```
extends LinkButton

func _on_LinkButton2_pressed():
	Transition.change_scene("res://scenes/Level 2.tscn")
```
## Transition
Terakhir adalah pembuatan transisi untuk game. Transisi yang saya buat merupakan transisi fade in dan out berwarna putih. Berikut langkah pengerjaan yang saya lakukan:

### Langkah Awal
- Saya pertama-tama membuat scene baru yang akan menjadi sebuah animasi untuk transisi
- Scene ini menggunakan CanvasLayer agar selalu berada di paling atas layar.
- Kemudian scene ditambahkan sebuah ColorRect untuk animasi fade in/out
- Terakhir tambahkan AnimationPlayer untuk animasinya

### Langkah 1: Pembuatan Animasi
- Pertama saya buat ColorRect dengan warna putih dan atur ukuran untuk memenuhi layar atau dalam layout pilih Full Rect
- Kemudian buat animasi baru pada AnimationPlayer dengan nama "RESET" dan juga "dissolve"
- Lalu kita akan atur dan manfaatkan Keyframe untuk membuat sebuah animasi. Dimulai dengan ColorRect dalam kondisi transparan sebagai Keyframe awal dan tidak transparan sebagai Keyframe terakhir
- Terakhir saya mengatur seberapa cepat animasi tersebut berjalan

### Langkah 2: Scripting
- Setelah animasi selesai, saya tambahkan sebuah script untuk menjalankan animasi tersebut. Berikut script:
```
extends CanvasLayer

func change_scene(target: String) -> void:
	$AnimationPlayer.play("dissolve")
	yield($AnimationPlayer,"animation_finished")
	get_tree().change_scene(target)
	$AnimationPlayer.play_backwards("dissolve")
```
- Kemudian saya simpan pada pengaturan AutoLoad pada Project Setting untuk dapat digunakan setiap saat
- Terakhir saya menggantikan setiap fungsi "get_tree()" dengan nama transisi yang saya simpan tersebut pada bagian yang saya ingin berikan transisi
- Tidak lupa juga saya memodifikasi code script untuk Area2D untuk membedakan pemindahan level dengan reset level seperti berikut:
```
extends Area2D

export(String) var sceneName = "Level 1"

func _on_Area_Trigger_body_entered(body):
	var current_scene = get_tree().get_current_scene().get_name()
	if current_scene == sceneName:
		global.lives -=1
	if body.get_name() == "Player":
		if (global.lives == 0):
			Transition.change_scene(str("res://scenes/Game Over.tscn"))
		else:
			if current_scene != sceneName:
				Transition.change_scene(str("res://scenes/" + sceneName + ".tscn"))
			else:
				get_tree().change_scene(str("res://scenes/" + sceneName + ".tscn"))
```