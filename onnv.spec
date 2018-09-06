Name: onnv-linux
Version: 1.0
Release: 1%{?dist}
Summary: Solaris Userspace for Linux

License: CDDL
URL: https://github.com/msolberg/onnv-linux
Source: onnv-linux-1.0.tar.gz

BuildRequires: gcc

%description
Solaris Userspace for Linux


%prep
%setup


pushd usr/src/cmd
make %{?_smp_mflags} -f Makefile.linux
popd


%install
pushd usr/src/cmd
make install -f Makefile.linux DESTDIR=${RPM_BUILD_ROOT}/usr/solaris/
popd 


%files
/usr/solaris/bin/true
/usr/solaris/bin/cal
/usr/solaris/bin/head

%changelog

