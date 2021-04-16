/*
Copyright 2015, 2016 OpenMarket Ltd
Copyright 2019 New Vector Ltd

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

import React from 'react';
import PropTypes from 'prop-types';
import SdkConfig from 'matrix-react-sdk/src/SdkConfig';

export default class VectorAuthHeaderLogo extends React.PureComponent {
    static replaces = 'AuthHeaderLogo'

    static propTypes = {
        icon: PropTypes.string,
    }

    render() {
        const config = SdkConfig.get();
        const brandingConfig = SdkConfig.get().branding;
        const logoSecondaryDescription = config?.logo?.logo_secondary?.description;
        const showSecondaryLogoOnLoginScreen = config?.logo?.showSecondaryLogoOnLoginScreen;
        let logoUrl = "themes/element/img/logos/element-logo.svg";
        let logoUrlSecondary = "themes/element/img/logos/element-logo-secondary.png";
        if (brandingConfig && brandingConfig.authHeaderLogoUrl) {
            logoUrl = brandingConfig.authHeaderLogoUrl;
        }

        const logoSecondaryStyle = {
            marginBottom: '25px'
        }

        return (
            <div className="mx_AuthHeaderLogo">
                {showSecondaryLogoOnLoginScreen && <img src={logoUrlSecondary} style={logoSecondaryStyle} alt={logoSecondaryDescription}/>}
                <img src={logoUrl} alt="Element"/>
            </div>
        );
    }
}
