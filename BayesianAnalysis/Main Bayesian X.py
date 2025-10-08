#!/usr/bin/env python
# coding: utf-8

# In[7]:


from qutip import *
import time
from pylab import *
import numpy as np
from scipy.special import comb
import math
from scipy.stats import norm
import os
import matplotlib.pyplot as plt
from scipy.optimize import curve_fit

plt.rcParams['axes.labelsize']  = 18
plt.rcParams['axes.titlesize']  = 16
plt.rcParams['xtick.labelsize'] = 16
plt.rcParams['ytick.labelsize'] = 16
plt.rcParams['legend.fontsize'] = 16

save_data = './Data Aux/'


# In[8]:


def experiments(trials_vec):
    
    # Fix: Seed RNG uniquely for each parallel process
    seed = int((time.time() * 1e6) % 2**32) + os.getpid() + trials_vec
    np.random.seed(seed)

    ##---------------------------------------------------------------------------##
    ## Complete Knowledge:
    ##---------------------------------------------------------------------------##

    B                          = np.sqrt(Bx_god**2 + Bz_god**2)
    nx                         = Bx_god / B
    nz                         = Bz_god / B

    P_god_correcting_kx_errors = []
    for k in range(N):
        pkaux = comb(N-1, k) * ((cos(B))**2 + (nz*sin(B))**2)**(N-1-k) * (nx*sin(B))**(2*k)

        P_god_correcting_kx_errors.append( pkaux )

    p_aux_kx_errors            = P_god_correcting_kx_errors[0:N-1]
    p_aux_kx_errors            = np.array(p_aux_kx_errors)

    p_aux_kx_errors[np.abs(p_aux_kx_errors) < remove_prob_below] = 0
    p_aux_kx_errors            = list(p_aux_kx_errors)

    p_aux_kx_errors.append(np.abs(1.0 - sum(p_aux_kx_errors)))
    P_god_correcting_kx_errors = p_aux_kx_errors

    prior           = 1.0
    prior_effective = 1.0

    for iteration in range(itmax):

        ##---------------------------------------------------------------------------##
        ## Laboratory:
        ##---------------------------------------------------------------------------##
        random_data_kx_errors = list(np.random.choice(N, M, p = P_god_correcting_kx_errors) )

        ##---------------------------------------------------------------------------##
        ## Bayesian:
        ##---------------------------------------------------------------------------##

        # Counting Errors
        counting_errors      = []
        for idx in range(N):
            counting_errors.append(random_data_kx_errors.count(idx))

        likelihood_surface = []
        for Bx in Bx_vec:
            likelihood_aux = []
            for Bz in Bz_vec:
                B          = np.sqrt(Bx**2 + Bz**2)
                nx         = Bx / B
                nz         = Bz / B

                pk_prod_aux = []
                for k in range(N): 
                    pk_prod_aux.append((comb(N-1, k) *                                       ((cos(B))**2 + (nz*sin(B))**2)**(N-1-k) *                                        (nx*sin(B))**(2*k))**counting_errors[k] )

                likelihood_aux.append(np.prod(pk_prod_aux))

            likelihood_surface.append( likelihood_aux )

        posterior_not_normalized      = np.multiply(likelihood_surface, prior)
        normalization                 = np.trapz(np.trapz(                                                 posterior_not_normalized, Bz_vec), Bx_vec)

        prior                         = np.divide(posterior_not_normalized, normalization)

        ################### Beff
        ###Now we include the information of having a B effective in the resulting state.

        for k in range(N):
            ##---------------------------------------------------------------------------##
            ## Complete Knowledge:
            ##---------------------------------------------------------------------------##

            B                          = np.sqrt(Bx_god**2 + Bz_god**2)
            nx                         = Bx_god / B
            nz                         = Bz_god / B

            Beff                       = math.atan( nz * tan(B) )

            P_god                      = [(cos(0.5 * 2 * Beff * (N - 1 - k)))**2,                                           1.0 - (cos(0.5 * 2 * Beff * (N - 1 - k)))**2 ]

            ##---------------------------------------------------------------------------##
            ## Laboratory:
            ##---------------------------------------------------------------------------##
            random_data_kx_errors_Beff = list(np.random.choice(2, counting_errors[k], p = P_god) )

            ##---------------------------------------------------------------------------##
            ## Bayesian:
            ##---------------------------------------------------------------------------##

            # Counting Errors
            counting_errors_Beff = []
            for idx in range(N):
                counting_errors_Beff.append(random_data_kx_errors_Beff.count(idx))

            likelihood_Beff_aux = []
            for Beff in Beff_vec:
                likelihood_Beff_aux.append( ((cos(0.5 * 2 * Beff * (N - 1 - k)))**2)**counting_errors_Beff[0] *                                             ((sin(0.5 * 2 * Beff * (N - 1 - k)))**2)**counting_errors_Beff[1]  )

            posterior_not_normalized_eff  = np.multiply(likelihood_Beff_aux, prior_effective)
            normalization_eff             = np.trapz(posterior_not_normalized_eff, Beff_vec)

            prior_effective               = np.divide(posterior_not_normalized_eff, normalization_eff)


    Beff_est = Beff_vec[np.argmax(prior_effective)]

    G        = []

    for Bx in Bx_vec:
        Gaux = []
        for Bz in Bz_vec:
            B    = np.sqrt(Bx**2 + Bz**2)
            nz   = Bz / B
            Beff = math.atan( nz * tan(B) )

            if np.abs(Beff - Beff_est) <= tol:
                Gaux.append( Beff )
            else:
                Gaux.append( 0 )
        G.append( Gaux )

    # Find the maximum value and its coordinates
    max_value  = np.array(np.multiply(G, prior)).max()
    max_coords = np.unravel_index(np.array(np.multiply(G, prior)).argmax(),                                   np.array(np.multiply(G, prior)).shape)
        
    return Bx_vec[max_coords[0]],            Bz_vec[max_coords[1]]


# In[10]:


tol               = 0.001
Bx_god            = 1.0
Bz_god            = 0.1
remove_prob_below = 1e-4
itmax             = 20
M                 = 200
n_points          = 100


# In[11]:


Beff_vec  = np.linspace(0.1, 0.2, 1000)

###
Bxmin     = 0.9
Bxmax     = 1.05
Bzmin     = 0.06
Bzmax     = 0.15

sigmax    = (Bxmax - Bxmin) / 2
sigmaz    = (Bzmax - Bzmin) / 2

idx_vec   = range(1, 6)

N_vec     = [10]

for N in N_vec:
    
    ux        = np.linspace(norm.cdf(Bxmin, Bx_god, sigmax),                             norm.cdf(Bxmax, Bx_god, sigmax), n_points)
    Bx_vec    = norm.ppf(ux, Bx_god, sigmax)

    uz        = np.linspace(norm.cdf(Bzmin, Bz_god, sigmaz),                             norm.cdf(Bzmax, Bz_god, sigmaz), n_points)
    Bz_vec    = norm.ppf(uz, Bz_god, sigmaz)

    for idx in idx_vec:
                
        total_experiments = range(200)

        aux     = parfor(experiments, total_experiments)

        results = {
                "Bx_estimated": aux[0],
                "Bz_estimated": aux[1],}

        filename = f"Estimation_X_errors_{idx}_N={N}.npz"
        full_path = os.path.join(save_data, filename)

        np.savez(full_path, **results)


    plt.figure(figsize=(6, 6))

    color_vec = ['blue', 'red', 'black', 'green', 'magenta']

    # Initialize global min/max values
    Bx_all = []
    Bz_all = []

    for idx in idx_vec:
        # Load the data
        filename  = f"Estimation_X_errors_{idx}_N={N}.npz"
        full_path = os.path.join(save_data, filename)
        data      = np.load(full_path)

        Bx_est = data['Bx_estimated']
        Bz_est = data['Bz_estimated']

        Bx_all.append(Bx_est)
        Bz_all.append(Bz_est)

        plt.scatter(Bx_est, Bz_est, c=color_vec[idx - 1], alpha=0.6)

    # Concatenate all data into one array for each coordinate
    Bx_all = np.concatenate(Bx_all)
    Bz_all = np.concatenate(Bz_all)

    Bxmin     = Bx_all.min() 
    Bxmax     = Bx_all.max() 
    Bzmin     = Bz_all.min() 
    Bzmax     = Bz_all.max()
    
    sigmax    = (Bxmax - Bxmin) / 2
    sigmaz    = (Bzmax - Bzmin) / 2

    plt.xlabel(r"$B_x^{\mathrm{estimated}}$")
    plt.ylabel(r"$B_z^{\mathrm{estimated}}$")
    plt.tight_layout()
    plt.xlim(Bx_vec[0], Bx_vec[-1])
    plt.ylim(Bz_vec[0], Bz_vec[-1])
    plt.savefig(save_data +                         "X_Scattered_QEC_Sensor_N="+str(N)+".pdf",                 bbox_inches='tight')
    plt.close()

