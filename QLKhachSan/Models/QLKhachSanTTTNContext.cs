using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace QLKhachSan.Models
{
    public partial class QLKhachSanTTTNContext : DbContext
    {
        public QLKhachSanTTTNContext()
        {
        }

        public QLKhachSanTTTNContext(DbContextOptions<QLKhachSanTTTNContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Admin> Admins { get; set; } = null!;
        public virtual DbSet<Blog> Blogs { get; set; } = null!;
        public virtual DbSet<Ctanh> Ctanhs { get; set; } = null!;
        public virtual DbSet<DatPhong> DatPhongs { get; set; } = null!;
        public virtual DbSet<GopY> Gopies { get; set; } = null!;
        public virtual DbSet<HoaDon> HoaDons { get; set; } = null!;
        public virtual DbSet<KhachHang> KhachHangs { get; set; } = null!;
        public virtual DbSet<KhachSan> KhachSans { get; set; } = null!;
        public virtual DbSet<LoaiPhong> LoaiPhongs { get; set; } = null!;
        public virtual DbSet<Phong> Phongs { get; set; } = null!;
        public virtual DbSet<QuenMatKhau> QuenMatKhaus { get; set; } = null!;
        public virtual DbSet<SuDungThietBi> SuDungThietBis { get; set; } = null!;
        public virtual DbSet<ThietBi> ThietBis { get; set; } = null!;
        public virtual DbSet<TinhThanh> TinhThanhs { get; set; } = null!;

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
                optionsBuilder.UseSqlServer("Data Source=LAPTOP-DUY;Initial Catalog=QLKhachSanTTTN;Integrated Security=True;Connect Timeout=30;Encrypt=True;Trust Server Certificate=True;Application Intent=ReadWrite;Multi Subnet Failover=False");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Admin>(entity =>
            {
                entity.ToTable("Admin");

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.Email).HasMaxLength(50);

                entity.Property(e => e.Password).HasMaxLength(50);
            });

            modelBuilder.Entity<Blog>(entity =>
            {
                entity.ToTable("Blog");

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.Anh).HasMaxLength(50);

                entity.Property(e => e.Idadmin).HasColumnName("IDAdmin");

                entity.Property(e => e.NgayDang).HasColumnType("date");

                entity.Property(e => e.ThongTin).HasColumnType("text");

                entity.HasOne(d => d.IdadminNavigation)
                    .WithMany(p => p.Blogs)
                    .HasForeignKey(d => d.Idadmin)
                    .HasConstraintName("FK_Blog_NhanVien");
            });

            modelBuilder.Entity<Ctanh>(entity =>
            {
                entity.HasKey(e => e.TenAnh);

                entity.ToTable("CTAnh");

                entity.Property(e => e.TenAnh).HasMaxLength(50);

                entity.HasOne(d => d.MaPhongNavigation)
                    .WithMany(p => p.Ctanhs)
                    .HasForeignKey(d => d.MaPhong)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("FK_CTAnh_MaPhong");
            });

            modelBuilder.Entity<DatPhong>(entity =>
            {
                entity.HasKey(e => new { e.MaPhong, e.SoHoaDon });

                entity.ToTable("DatPhong");

                entity.Property(e => e.NgayDen).HasColumnType("datetime");

                entity.Property(e => e.NgayDi).HasColumnType("datetime");

                entity.Property(e => e.NgayHuy).HasColumnType("datetime");

                entity.HasOne(d => d.MaPhongNavigation)
                    .WithMany(p => p.DatPhongs)
                    .HasForeignKey(d => d.MaPhong)
                    .HasConstraintName("FK_DatPhong_Phong");

                entity.HasOne(d => d.SoHoaDonNavigation)
                    .WithMany(p => p.DatPhongs)
                    .HasForeignKey(d => d.SoHoaDon)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_DatPhong_HoaDon");
            });

            modelBuilder.Entity<GopY>(entity =>
            {
                entity.ToTable("GopY");

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.MaKh).HasColumnName("MaKH");

                entity.Property(e => e.MaKs).HasColumnName("MaKS");

                entity.Property(e => e.NgayComment).HasColumnType("datetime");

                entity.HasOne(d => d.MaKhNavigation)
                    .WithMany(p => p.Gopies)
                    .HasForeignKey(d => d.MaKh)
                    .HasConstraintName("FK_GopY_KhachHang");

                entity.HasOne(d => d.MaKsNavigation)
                    .WithMany(p => p.Gopies)
                    .HasForeignKey(d => d.MaKs)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("FK_GopY_KhachSan");
            });

            modelBuilder.Entity<HoaDon>(entity =>
            {
                entity.HasKey(e => e.SoHoaDon);

                entity.ToTable("HoaDon");

                entity.Property(e => e.Email).HasMaxLength(200);

                entity.Property(e => e.MaKh).HasColumnName("MaKH");

                entity.Property(e => e.NgayTao).HasColumnType("datetime");

                entity.Property(e => e.NgayThanhToan).HasColumnType("datetime");

                entity.Property(e => e.Sdt)
                    .HasMaxLength(50)
                    .HasColumnName("SDT");

                entity.Property(e => e.TenKh)
                    .HasMaxLength(50)
                    .HasColumnName("TenKH");

                entity.Property(e => e.TinhTrang).HasMaxLength(50);

                entity.HasOne(d => d.MaKhNavigation)
                    .WithMany(p => p.HoaDons)
                    .HasForeignKey(d => d.MaKh)
                    .HasConstraintName("FK_HoaDon_KhachHang");
            });

            modelBuilder.Entity<KhachHang>(entity =>
            {
                entity.HasKey(e => e.MaKh);

                entity.ToTable("KhachHang");

                entity.Property(e => e.MaKh).HasColumnName("MaKH");

                entity.Property(e => e.DiaChi).HasMaxLength(50);

                entity.Property(e => e.Email).HasMaxLength(50);

                entity.Property(e => e.NgaySinh).HasColumnType("date");

                entity.Property(e => e.Password).HasMaxLength(50);

                entity.Property(e => e.Sdt)
                    .HasMaxLength(50)
                    .HasColumnName("SDT");

                entity.Property(e => e.TenKh)
                    .HasMaxLength(50)
                    .HasColumnName("TenKH");
            });

            modelBuilder.Entity<KhachSan>(entity =>
            {
                entity.HasKey(e => e.MaKs);

                entity.ToTable("KhachSan");

                entity.Property(e => e.MaKs).HasColumnName("MaKS");

                entity.Property(e => e.Anh).HasMaxLength(50);

                entity.Property(e => e.IdnguoiTao).HasColumnName("IDNguoiTao");

                entity.Property(e => e.TenKhachSan).HasMaxLength(200);

                entity.HasOne(d => d.IdnguoiTaoNavigation)
                    .WithMany(p => p.KhachSans)
                    .HasForeignKey(d => d.IdnguoiTao)
                    .HasConstraintName("FK_KhachSan_KhachHang");

                entity.HasOne(d => d.MaTinhNavigation)
                    .WithMany(p => p.KhachSans)
                    .HasForeignKey(d => d.MaTinh)
                    .HasConstraintName("FK_KhachSan_TinhThanh");
            });

            modelBuilder.Entity<LoaiPhong>(entity =>
            {
                entity.HasKey(e => e.MaLp);

                entity.ToTable("LoaiPhong");

                entity.Property(e => e.MaLp).HasColumnName("MaLP");

                entity.Property(e => e.Anh).HasMaxLength(50);

                entity.Property(e => e.KichThuoc).HasMaxLength(20);

                entity.Property(e => e.MaKs).HasColumnName("MaKS");

                entity.Property(e => e.TenLp)
                    .HasMaxLength(50)
                    .HasColumnName("TenLP");

                entity.HasOne(d => d.MaKsNavigation)
                    .WithMany(p => p.LoaiPhongs)
                    .HasForeignKey(d => d.MaKs)
                    .HasConstraintName("FK_LoaiPhong_KhachSan");
            });

            modelBuilder.Entity<Phong>(entity =>
            {
                entity.HasKey(e => e.MaPhong);

                entity.ToTable("Phong");

                entity.Property(e => e.Anh).HasMaxLength(50);

                entity.Property(e => e.MaLp).HasColumnName("MaLP");

                entity.Property(e => e.TenPhong).HasMaxLength(50);

                entity.HasOne(d => d.MaLpNavigation)
                    .WithMany(p => p.Phongs)
                    .HasForeignKey(d => d.MaLp)
                    .HasConstraintName("FK_Phong_LoaiPhong");
            });

            modelBuilder.Entity<QuenMatKhau>(entity =>
            {
                entity.ToTable("QuenMatKhau");

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.Email).HasMaxLength(50);

                entity.Property(e => e.NgayTao).HasColumnType("datetime");
            });

            modelBuilder.Entity<SuDungThietBi>(entity =>
            {
                entity.ToTable("SuDungThietBi");

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.MaLp).HasColumnName("MaLP");

                entity.Property(e => e.MaTb).HasColumnName("MaTB");

                entity.HasOne(d => d.MaLpNavigation)
                    .WithMany(p => p.SuDungThietBis)
                    .HasForeignKey(d => d.MaLp)
                    .HasConstraintName("FK_SuDungThietBi_LoaiPhong");

                entity.HasOne(d => d.MaTbNavigation)
                    .WithMany(p => p.SuDungThietBis)
                    .HasForeignKey(d => d.MaTb)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_SuDungThietBi_ThietBi");
            });

            modelBuilder.Entity<ThietBi>(entity =>
            {
                entity.HasKey(e => e.MaTb);

                entity.ToTable("ThietBi");

                entity.Property(e => e.MaTb).HasColumnName("MaTB");

                entity.Property(e => e.TenTb)
                    .HasMaxLength(200)
                    .HasColumnName("TenTB");
            });

            modelBuilder.Entity<TinhThanh>(entity =>
            {
                entity.HasKey(e => e.MaTinh);

                entity.ToTable("TinhThanh");

                entity.Property(e => e.Anh).HasMaxLength(50);

                entity.Property(e => e.TenTinh).HasMaxLength(50);
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
