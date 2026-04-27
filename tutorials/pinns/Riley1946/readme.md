### Building a NN and PINN for the phytoplankton model presented in Gordon Riley's 1946 paper

1. **Standard Neural Network** trained only on data.
2. **Physics-Informed Neural Network (PINN)** trained on data *and* the phytoplankton ODE.

---

There are 3 versions of the PINN code available:

* `riley1946_pinn_pinn-tutorial.ipynb`: example with incomplete PINN and missing dynamics/physics loss
* `riley1946_pinn_data-loading-only.ipynb`: least complete example; only the data is loaded and prepared
* `riley1946_pinn_complete-example.ipynb`: complete example with full PINN implementation

In addition, `riley1946_forward.ipynb` includes only the forward model introduced in Riley (1946) without a neural network.

---

### Implement neural networks to emulate Riley's 1946 phytoplankton model

Riley (1946) "Factors controlling phytoplankton populations on Georges Bank" is available [online](https://elischolar.library.yale.edu/journal_of_marine_research/624/).

The ODE presented in Riley (1946) is:

$$
\frac{dP}{dt} = P\left(P_h - R - G\right)
$$

Where:

* $P_h = p \, \frac{I_0}{k z_1} \, (1 - e^{-k z_1}) \, (1 - N) \, (1 - V)$: phytoplankton growth/increase
* $R = R_0 \, e^{r T}$: temperature-dependent respiration
* $G = g \, Z$: zooplankton grazing

We use the measurements reported in Riley (1946) to train

* a NN to learn $P(t)$, $Z(t)$ and $P_h(t)/p$, $R(t)/R_0$
* a PINN that minimizes both data loss and residual of the ODE and optionally estimates the parameters $p$, $R_0$, and $G$ that scale the 3 source and sink terms

The 4 terms $P(t)$, $Z(t)$ and $P_h(t)/p$, $R(t)/R_0$ were measured or estimated based on measurements from surveys conducted on Georges Bank over the course of several years. The data are meant to represent a climatological seasonal cycle. Estimates for the  $p$, $R_0$, and $G$ are presented in Riley (1946) along with those for a few other parameters. Here, we simplify things a bit by only considering 4 model state variables ($P(t)$, $Z(t)$, $P_h(t)/p$, and $R(t)/R_0$) and 3 scaling parameters. In Riley (1946), $P_h(t)$, and $R(t)$ are made up of other state estimates and additional parameters that we aggregate here. However, the data files contain all state estimates recorded in the paper, so a more detailed analysis is possible.
