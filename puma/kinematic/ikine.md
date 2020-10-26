
## puma560 前三轴逆运动学





符号：

$\vec{p}$ 为旋转关节2到3的距离向量
$(x_d, y_d, z_d)$ 为末端执行器相对于世界坐标系的坐标
$h$ 为第一个关节与基座的距离


$\vec{p} = (p_x, p_y, p_z)^T$

正运动学推导出下式：
$x_d=p_xc_1c_2 -p_yc_1s_2 + p_zs_1 -p_{12}s_1 -e_xc_1s_{23} ······(1)$

$y_d=p_xs_1c_2 -p_ys_1s_2 - p_zc_1 +p_{12}c_1-e_xs_1s_{23}······(2)$

$z_d' = z_d-h = p_xs_2 + p_yc_2 + e_xc_{23}······(3)$

---

三式平方相加：
$x_d^2 + y_d^2 + z_d'^2 = \vec{p}^T \vec{p} + p_{12}^2+e_x^2 - 2p_{12}p_z -2e_x(p_xs_3 - p_yc_3)$

可解出第三个关节角$\theta_3$ ：
$sin(\theta_3-\alpha_3) = \frac{\vec{p}\vec{p}^T + p_{12}^2+e_x^2 - 2p_{12}p_z - (x_d^2 + y_d^2 + z_d'^2)}{2e_x \sqrt{p_x^2 + p_y^2}} = k_3$

$tan \alpha_3 = \frac{p_y}{p_x} $
$\theta_3 = \alpha_3 + asin(k_3)$
或
$\theta_3 = \alpha_3 + \pi - asin(k_3)$

---

进而通过式(3)解出$\theta_2$：
$sin(\theta_2 + \alpha_2) = \frac{z_d'}{\sqrt{x_d^2 + y_d^2 + z_d'^2 - (p_{12}-p_z)^2}} = k_2$ 

$tan \alpha_2 = \frac{p_y + e_xc_3}{p_x - e_xs_3}$

$\theta_2 = asin(k_2) - \alpha_2$
或
$\theta_2 = \pi - asin(k_2) - \alpha_2$


---

最后通过式(1),(2)解出$\theta_1$：
$x_d = (p_xc_2 - p_ys_2-e_xs_{23})c_1 + (p_z-p_{12})s_1 = kx_1c_1 + kx_2s_1$
$y_d = (p_{12}-p_z)c_1 + (p_xc_2-p_ys_2-e_xs_{23})s_1= ky_1c_1 + ky_2s_1$ 

$\theta_1 = atan(\frac{y_dkx_1 - x_dky_1}{x_dky_2 - y_dkx_2})$

---

## conditions

解的存在性：必须满足以下条件，才有解！！

$A = \vec{p}\vec{p}^T + p_{12}^2+e_x^2 - 2p_{12}p_z$
$B = 2e_x\sqrt{p_x^2+p_y^2}$
$C = x_d^2+y_d^2+z_d'^2$

1. $B-A \le C \le B+A$
2. $x_d^2+y_d^2 \ge (p_{12} - p_z)^2$


## 解的个数

$\theta_3$两个解，$\theta_2$两个解，$\theta_1$一个解，一共2*2*1=4个解

