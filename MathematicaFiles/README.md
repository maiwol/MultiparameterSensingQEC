# Mathematica files

These files are used to generate the analytical expressions for the quantum and classical Fisher information matrices.

- **CRSaturation.nb** shows that the classical Fisher information (CFI) matrices of the ancilla-assisted protocol for a (N+1)-qubit probe are equal to the quantum Fisher information matrices of an uncorrected N-qubit probe.
- **GeneratingResults.nb** computes the CFI matrices for a set of N, Bx, and Bz values for 3 different protocols: no QEC, ancilla-free QEC, and ancilla-assisted QEC.  Beware that his takes a long time to run.
- **JointMeasCartesianCoord.nb** generates the analytical expressions for the CFI matrices of the ancilla-assisted protocol.
- **ScalingAncillaFreeProtocol.nb** generates expressions for the CFI matrices of the ancilla-free protocol.
- **SimplifyingExpressionsCFI.nb** simplifies the CFI expressions of the ancilla-assisted protocol to obtain the forms presented in the manuscript.  (When using Mathematica's FullSimplify command, the expressions end up having 4 parameters.  The expressions with 3 parameters presented in the manuscript are a bit more elegant.).
